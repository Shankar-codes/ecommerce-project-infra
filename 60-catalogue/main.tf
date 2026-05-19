# catalogue instance
resource "aws_instance" "catalogue" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id = local.private_subnet_ids

  tags =merge(local.common_tags, {
      Name = "${var.project_name}-${var.environment}-Catalogue"
      Terraform = "true"
  }
  )
}

#this is null resource
resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.catalogue.private_ip
}

# Provisioner to copy the file - terraform copies the file to the ec2 instance
provisioner "file" {
  source      = "catalogue.sh"       # Local file path
  destination = "/tmp/catalogue.sh"      # Remote path on EC2
}

provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/catalogue.sh",
      "sudo sh /tmp/catalogue.sh catalogue"
    ]
  }
}

# creating R53 record for catalogue server catalogue.ellamma.fun
resource "aws_route53_record" "catalogue" {
  zone_id = var.zone_id
  name    = "catalogue.${var.domain_name}" #catalogue.ellamma.fun
  type    = "A"
  ttl     = 1
  records = [aws_instance.catalogue.private_ip]
}

# stopping the catalogue instance 
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped" # Change to "running" to start the instance
  depends_on = [terraform_data.catalogue]
}

# creating AMI from the catalogue instance
resource "aws_ami_from_instance" "catalogue" {
  name               = "${var.project_name}-${var.environment}-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [aws_ec2_instance_state.catalogue]
}

# target group for the catalogue instance
resource "aws_lb_target_group" "catalogue" {
  name     = "${local.common_name_suffix}-catalogue"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  deregistration_delay = 60 #waiting for 60 seconds before deregistering the instance from the target group
  health_check {
    path                = "/health"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

# creating launch template for the catalogue instance
resource "aws_launch_template" "catalogue" {
  name = "${local.common_name_suffix}-catalogue"
  image_id = "aws_ami_from_instance.catalogue.id"
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"

  vpc_security_group_ids = ["local.catalogue_sg_id"]
  update_default_version = true


  tag_specifications {
  resource_type = "instance"

  tags = merge(local.common_tags, {
    Name = "${local.common_name_suffix}-catalogue"
  })
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(local.common_tags, {
      Name = "${local.common_name_suffix}-catalogue"
    })
  }
}

# auto scaling group for the catalogue instance
resource "aws_autoscaling_group" "catalogue" {
  name                      = "${local.common_name_suffix}-catalogue"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete               = false
  launch_template {
    id      = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version
  }

  vpc_zone_identifier       = [local.private_subnet_ids]
  target_group_arns         = [aws_lb_target_group.catalogue.arn]

  timeouts {
    delete = "15m"
  }
}

resource "aws_autoscaling_policy" "catalogue" {
  name                   = "${local.common_name_suffix}-catalogue"
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}


resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = local.backend_alb_listener_arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  condition {
    host_header {
      values = ["catalogue.backend-alb-${var.domain_name}"]
    }
  }
}

resource "terraform_data" "catalogue_local" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

depends_on = [aws_autoscaling_policy.catalogue]

provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id}"
  }
}