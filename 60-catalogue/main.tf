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

resource "aws_route53_record" "catalogue" {
  zone_id = var.zone_id
  name    = "catalogue.${var.domain_name}" #catalogue.ellamma.fun
  type    = "A"
  ttl     = 1
  records = [aws_instance.catalogue.private_ip]
}