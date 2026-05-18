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
resource "aws_ami_from_instance" "example" {
  name               = "${var.project_name}-${var.environment}-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [aws_ec2_instance_state.catalogue]
}