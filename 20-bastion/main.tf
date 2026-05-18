resource "aws_instance" "bastion" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_ids
  user_data = file("bastion.sh")
  iam_instance_profile = aws_iam_instance_profile.bastion.name
  tags =merge(local.common_tags, {
      Name = "${var.project_name}-${var.environment}-Bastion Host"
      Terraform = "true"
  }
  )

  resource "aws_iam_instance_profile" "bastion" {
  name = "bastion"
  role = "BastionAdminRole"
}

}