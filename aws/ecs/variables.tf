variable "vpc_id" {}

variable "subnets" {
  type = "list"
}

variable "security_groups" {
  type = "list"
}

variable "task_role_arn" {}
variable "execution_role_arn" {}

variable "images" {
  type = "map"
}

variable "rds" {
  type = "map"
}

variable "elasticache" {
  type = "map"
}
