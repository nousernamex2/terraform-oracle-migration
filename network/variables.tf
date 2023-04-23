variable "subnet_group_id_1" {
  type        = string
  description = "First of two subnets to designate your RDS database instance in a VPC"
}

variable "subnet_group_id_2" {
  type        = string
  description = "Second of two subnets to designate your RDS database instance in a VPC"
}