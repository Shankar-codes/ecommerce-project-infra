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
      "sudo chmod +x /tmp/bootstap.sh",
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
      "sudo chmod +x /tmp/bootstap.sh",
      "sudo sh /tmp/bootstap.sh redis"
    ]
  }
}


