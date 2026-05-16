locals {
  common_name_suffix = "${var.project_name}-${var.environment}"
  mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
  ami_id = data.aws_ami.ellamma_roboshop.id
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
  database_subnet_ids = split(",", data.aws_ssm_parameter.database_subnet_ids.value)[0]
  common_tags = {
    Project = var.project_name
    Environment = var.environment
    Terraform = "true"
  }
}
