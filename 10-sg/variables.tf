variable "project_name" {
  default = "ellamma-roboshop"
}

variable "environment" {
  default = "dev"
}

variable "sg_name" {
  default = ["mongodb", "redis", "mysql", "rabbitmq",
  "catalogue", "user", "cart", "shipping", "payment",
  "frontend",
  "bastion",
  "frontend_alb",
  "backend_alb"
  ]
}

variable "sg_description" {
  default = "Security group"
}