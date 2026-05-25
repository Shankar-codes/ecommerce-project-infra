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


# mongodb connecting to catalogue server on port 27017
resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  security_group_id = local.mongodb_sg_id # 
  source_security_group_id = local.catalogue_sg_id #
  from_port         = 27017
  protocol          = "tcp"
  to_port           = 27017
}

# user connecting to mongodb server on port 27017
resource "aws_security_group_rule" "mongodb_user" {
  type              = "ingress"
  security_group_id = local.mongodb_sg_id # 
  source_security_group_id = local.user_sg_id #
  from_port         = 27017
  protocol          = "tcp"
  to_port           = 27017
}

# user connecting to redis server on port 6379
resource "aws_security_group_rule" "redis_user" {
  type              = "ingress"
  security_group_id = local.redis_sg_id # 
  source_security_group_id = local.user_sg_id #
  from_port         = 6379
  protocol          = "tcp"
  to_port           = 6379
}

# cart connecting to redis server on port 6379
resource "aws_security_group_rule" "redis_cart" {
  type              = "ingress"
  security_group_id = local.redis_sg_id # 
  source_security_group_id = local.cart_sg_id #
  from_port         = 6379
  protocol          = "tcp"
  to_port           = 6379
}

# shipping connecting to mysql server on port 3306
resource "aws_security_group_rule" "mysql_shipping" {
  type              = "ingress"
  security_group_id = local.mysql_sg_id # 
  source_security_group_id = local.shipping_sg_id #
  from_port         = 3306
  protocol          = "tcp"
  to_port           = 3306
}

# catalogue connecting to cart server on port 8080
resource "aws_security_group_rule" "catalogue_cart" {
  type              = "ingress"
  security_group_id = local.catalogue_sg_id # 
  source_security_group_id = local.cart_sg_id #
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

# cart connecting to shipping server on port 8080
resource "aws_security_group_rule" "cart_shipping" {
  type              = "ingress"
  security_group_id = local.cart_sg_id # 
  source_security_group_id = local.shipping_sg_id #
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

# user connecting to payment server on port 8080
resource "aws_security_group_rule" "user_payment" {
  type              = "ingress"
  security_group_id = local.user_sg_id # 
  source_security_group_id = local.payment_sg_id #
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

# cart connecting to payment server on port 8080
resource "aws_security_group_rule" "cart_payment" {
  type              = "ingress"
  security_group_id = local.cart_sg_id # 
  source_security_group_id = local.payment_sg_id #
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

# payment connecting to rabbitmq server on port 5672
resource "aws_security_group_rule" "rabbitmq_payment" {
  type              = "ingress"
  security_group_id = local.rabbitmq_sg_id # 
  source_security_group_id = local.payment_sg_id #
  from_port         = 5672
  protocol          = "tcp"
  to_port           = 5672
}


# backend alb connecting to user server on port 8080
resource "aws_security_group_rule" "user_backend_alb" {
  type              = "ingress"
  security_group_id = local.user_sg_id # 
  source_security_group_id = local.backend_alb_sg_id #
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

# backend alb connecting to cart server on port 8080
resource "aws_security_group_rule" "cart_backend_alb" {
  type              = "ingress"
  security_group_id = local.cart_sg_id # 
  source_security_group_id = local.backend_alb_sg_id #
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

# backend alb connecting to shipping server on port 8080
resource "aws_security_group_rule" "shipping_backend_alb" {
  type              = "ingress"
  security_group_id = local.shipping_sg_id # 
  source_security_group_id = local.backend_alb_sg_id #
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}


# backend alb connecting to cart server on port 8080
resource "aws_security_group_rule" "payment_backend_alb" {
  type              = "ingress"
  security_group_id = local.payment_sg_id # 
  source_security_group_id = local.backend_alb_sg_id #
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

# backend alb connecting to catalogue server on port 8080
resource "aws_security_group_rule" "catalogue_backend_alb" {
  type              = "ingress"
  security_group_id = local.catalogue_sg_id # 
  source_security_group_id = local.backend_alb_sg_id #
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

# backend alb connecting to frontend server on port 80
resource "aws_security_group_rule" "backend_alb_frontend" {
  type              = "ingress"
  security_group_id = local.backend_alb_sg_id # 
  source_security_group_id = local.frontend_sg_id #
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

# frontend alb connecting to frontend alb server on port 80
resource "aws_security_group_rule" "frontend_frontend_alb" {
  type              = "ingress"
  security_group_id = local.frontend_alb_sg_id # 
  source_security_group_id = local.frontend_alb_sg_id #
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

# frontend alb
resource "aws_security_group_rule" "frontend_alb_public" {
  type              = "ingress"
  security_group_id = local.frontend_alb_sg_id #
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
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