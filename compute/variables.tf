variable "subnet_id" {
  type        = string
  description = "The subnet id can be anyone of the three private subnets."
}

variable "ami_value" {
  type        = string
  description = "The name of the AMI"
}

variable "standard_sg_rds" {
  type        = string
  description = "The SG of RDS migration DB"
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC ID"
}