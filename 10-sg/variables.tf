variable "project_name" {
  default = "ellamma-roboshop"
}

variable "environment" {
  default = "dev"
}

variable "sg_name" {
  default = [
  #databases
  "mongodb", "redis", "mysql", "rabbitmq",
  #backend
  "catalogue", "user", "cart", "shipping", "payment",
  #frontend
  "frontend",
  #bastion
  "bastion",
  #frontend alb
  "frontend_alb",
  #backend alb
  "backend_alb"
  ]
}

variable "sg_description" {
  default = "Security group"
}