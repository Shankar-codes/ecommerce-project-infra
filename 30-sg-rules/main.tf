resource "aws_security_group_rule" "backend_alb_bastion" {
  type              = "ingress"
  security_group_id = local.backend_alb_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

#bastion host connecting to mongodb server on port 22
resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  security_group_id = local.mongodb_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

#bastion host connecting to redis server on port 22
resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  security_group_id = local.redis_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

#bastion host connecting to rabbitmq server on port 22
resource "aws_security_group_rule" "rabbitmq_bastion" {
  type              = "ingress"
  security_group_id = local.rabbitmq_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

#bastion host connecting to mysql server on port 22
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  security_group_id = local.mysql_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

#bastion host connecting to catalogue server on port 22
resource "aws_security_group_rule" "catalogue_bastion" {
  type              = "ingress"
  security_group_id = local.catalogue_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}


#bastion host connecting to catalogue server on port 22
resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  security_group_id = local.mongodb_sg_id # 
  source_security_group_id = local.catalogue_sg_id #
  from_port         = 27017
  protocol          = "tcp"
  to_port           = 27017
}

#this is attached to bastion sg to allow ssh access from laptop to bastion host
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  security_group_id = local.bastion_sg_id
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}