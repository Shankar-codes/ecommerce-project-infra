resource "aws_instance" "bastion" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_ids
  tags =merge(local.common_tags, {
      Name = "${var.project_name}-${var.environment}-Bastion Host"
      Terraform = "true"
  }
  )
}