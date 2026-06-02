###### Mongo DB ######
#bastion host connecting to mongodb server on port 22
resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  security_group_id = local.mongodb_sg_id # 
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

###### redis SG rules ######
#bastion host connecting to redis server on port 22
resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  security_group_id = local.redis_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
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


######## mysql SG rules ######
#bastion host connecting to mysql server on port 22
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  security_group_id = local.mysql_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
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

######## rabbitmq SG rules ######
#bastion host connecting to rabbitmq server on port 22
resource "aws_security_group_rule" "rabbitmq_bastion" {
  type              = "ingress"
  security_group_id = local.rabbitmq_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
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

###### catalogue SG rules ######
#bastion host connecting to catalogue server on port 22
resource "aws_security_group_rule" "catalogue_bastion" {
  type              = "ingress"
  security_group_id = local.catalogue_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
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


####### user SG rules ######
#bastion host connecting to user server on port 22
resource "aws_security_group_rule" "user_bastion" {
  type              = "ingress"
  security_group_id = local.user_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
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


##### cart SG rules ######
#bastion host connecting to cart server on port 22
resource "aws_security_group_rule" "cart_bastion" {
  type              = "ingress"
  security_group_id = local.cart_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
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


####### shipping SG rules ######
#bastion host connecting to shipping server on port 22
resource "aws_security_group_rule" "shipping_bastion" {
  type              = "ingress"
  security_group_id = local.shipping_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
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


####### payment SG rules ######
#bastion host connecting to payment server on port 22
resource "aws_security_group_rule" "payment_bastion" {
  type              = "ingress"
  security_group_id = local.payment_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
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

resource "aws_security_group_rule" "payment_shipping" {
  type              = "ingress"
  security_group_id = local.payment_sg_id
  source_security_group_id = local.shipping_sg_id
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}


#### backend alb SG rules ######
resource "aws_security_group_rule" "backend_alb_bastion" {
  type              = "ingress"
  security_group_id = local.backend_alb_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
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

resource "aws_security_group_rule" "backend_alb_cart" {
  type              = "ingress"
  security_group_id = local.backend_alb_sg_id
  source_security_group_id = local.cart_sg_id
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

resource "aws_security_group_rule" "backend_alb_shipping" {
  type              = "ingress"
  security_group_id = local.backend_alb_sg_id
  source_security_group_id = local.shipping_sg_id
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

resource "aws_security_group_rule" "backend_alb_payment" {
  type              = "ingress"
  security_group_id = local.backend_alb_sg_id
  source_security_group_id = local.payment_sg_id
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

######## frontend SG rules ######
#bastion host connecting to payment server on port 22
resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  security_group_id = local.frontend_sg_id # 
  source_security_group_id = local.bastion_sg_id #
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

# frontend alb connecting to frontend alb server on port 80
resource "aws_security_group_rule" "frontend_frontend_alb" {
  type              = "ingress"
  security_group_id = local.frontend_sg_id # 
  source_security_group_id = local.frontend_alb_sg_id #
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

##### frontend alb sg rules ######
resource "aws_security_group_rule" "frontend_alb_public" {
  type              = "ingress"
  security_group_id = local.frontend_alb_sg_id #
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
}

##### bastion SG rules ######
#this is attached to bastion sg to allow ssh access from laptop to bastion host
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  security_group_id = local.bastion_sg_id
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

######## open vpn SG rules ######
resource "aws_security_group_rule" "open_vpn_public" {
  type              = "ingress"
  security_group_id = local.open_vpn_sg_id
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

resource "aws_security_group_rule" "open_vpn_943" {
  type              = "ingress"
  security_group_id = local.open_vpn_sg_id
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 943
  protocol          = "tcp"
  to_port           = 943
}

resource "aws_security_group_rule" "open_vpn_443" {
  type              = "ingress"
  security_group_id = local.open_vpn_sg_id
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
}

resource "aws_security_group_rule" "open_vpn_1194" {
  type              = "ingress"
  security_group_id = local.open_vpn_sg_id
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 1194
  protocol          = "tcp"
  to_port           = 1194
}

resource "aws_security_group_rule" "components_vpn" {
  for_each = local.vpn_ingress_rules
  type              = "ingress"
  security_group_id = each.value.sg_id
  source_security_group_id = local.open_vpn_sg_id
  from_port         = each.value.port
  protocol          = "tcp"
  to_port           = each.value.port
}