variable "subnet_id" {
  type        = string
  description = "The subnet id can be anyone of the three private subnets."
}

variable "volume_attachement_device_name" {
  type    = string
  default = "/dev/sdf"
}

variable "ami_value" {
  type        = string
  description = "The name of the AMI"
}

variable "aws_current_account_id" {
  type        = string
  description = "The current AWS Account ID"
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC ID"
}

variable "subnet_group_id_1" {
  type        = string
  description = "First of two subnets to designate your RDS database instance in a VPC"
}

variable "subnet_group_id_2" {
  type        = string
  description = "Second of two subnets to designate your RDS database instance in a VPC"
}

variable "standard_sg_rds" {
  type        = string
  description = "The SG of RDS migration DB"
}