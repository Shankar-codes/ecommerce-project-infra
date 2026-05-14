variable "project_name" {
  default = "ellamma-roboshop"
}

variable "environment" {
  default = "dev"
}

variable "sg_name" {
  default = ["catalogue-sg", "mongodb-sg", "redis-sg", "bastion-sg",
  "frontend-lb"]
}

variable "sg_description" {
  default = "Security group"
}