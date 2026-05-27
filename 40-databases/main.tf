# mongodb instance
resource "aws_instance" "mongodb" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id = local.database_subnet_ids
  tags =merge(local.common_tags, {
      Name = "${var.project_name}-${var.environment}-MongoDB"
      Terraform = "true"
  }
  )
}

#this is null resource
resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]


connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.mongodb.private_ip
}

# Provisioner to copy the file - terraform copies the file to the ec2 instance
provisioner "file" {
  source      = "bootstap.sh"       # Local file path
  destination = "/tmp/bootstap.sh"      # Remote path on EC2
}

provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstap.sh",
      "sudo sh /tmp/bootstap.sh mongodb"
    ]
  }
}

# redis instance
resource "aws_instance" "redis" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.redis_sg_id]
  subnet_id = local.database_subnet_ids
  tags =merge(local.common_tags, {
      Name = "${var.project_name}-${var.environment}-redis"
      Terraform = "true"
  }
  )
}

#this is null resource
resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]


connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.redis.private_ip
}

# Provisioner to copy the file - terraform copies the file to the ec2 instance
provisioner "file" {
  source      = "bootstap.sh"       # Local file path
  destination = "/tmp/bootstap.sh"      # Remote path on EC2
}

provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstap.sh",
      "sudo sh /tmp/bootstap.sh redis"
    ]
  }
}


# rabbitmq instance
resource "aws_instance" "rabbitmq" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.rabbitmq_sg_id]
  subnet_id = local.database_subnet_ids
  tags =merge(local.common_tags, {
      Name = "${var.project_name}-${var.environment}-rabbitmq"
      Terraform = "true"
  }
  )
}

#this is null resource
resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]


connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.rabbitmq.private_ip
}

# Provisioner to copy the file - terraform copies the file to the ec2 instance
provisioner "file" {
  source      = "bootstap.sh"       # Local file path
  destination = "/tmp/bootstap.sh"      # Remote path on EC2
}

provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstap.sh",
      "sudo sh /tmp/bootstap.sh rabbitmq"
    ]
  }
}


# mysql instance
resource "aws_instance" "mysql" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id = local.database_subnet_ids
  iam_instance_profile = aws_iam_instance_profile.mysql.name
  tags =merge(local.common_tags, {
      Name = "${var.project_name}-${var.environment}-mysql"
      Terraform = "true"
  }
  )
}

resource "aws_iam_instance_profile" "mysql" {
  name = "mysql"
  role = "EC2ssmParameterRead"
}

#this is null resource
resource "terraform_data" "mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]


connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.mysql.private_ip
}

# Provisioner to copy the file - terraform copies the file to the ec2 instance
provisioner "file" {
  source      = "bootstap.sh"       # Local file path
  destination = "/tmp/bootstap.sh"      # Remote path on EC2
}

provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstap.sh",
      "sudo sh /tmp/bootstap.sh mysql"
    ]
  }
}

resource "aws_route53_record" "mongodb" {
  zone_id = var.zone_id
  name    = "mongodb.${var.domain_name}" #mongodb.ellamma.fun
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
}

resource "aws_route53_record" "redis" {
  zone_id = var.zone_id
  name    = "redis.${var.domain_name}" #redis.ellamma.fun
  type    = "A"
  ttl     = 1
  records = [aws_instance.redis.private_ip]
}

resource "aws_route53_record" "rabbitmq" {
  zone_id = var.zone_id
  name    = "rabbitmq.${var.domain_name}" #rabbitmq.ellamma.fun
  type    = "A"
  ttl     = 1
  records = [aws_instance.rabbitmq.private_ip]
}

resource "aws_route53_record" "mysql" {
  zone_id = var.zone_id
  name    = "mysql.${var.domain_name}" #mysql.ellamma.fun
  type    = "A"
  ttl     = 1
  records = [aws_instance.mysql.private_ip]
}