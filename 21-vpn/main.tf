resource "aws_instance" "open_vpn" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.open_vpn_sg_id]
  subnet_id = local.public_subnet_ids

  user_data = file("openvpn.sh")
  tags =merge(local.common_tags, {
      Name = "${var.project_name}-${var.environment}-openvpn"
      Terraform = "true"
  }
  )
}  

