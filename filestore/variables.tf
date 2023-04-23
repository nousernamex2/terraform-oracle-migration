variable "subnet_id" {
  type        = string
  description = "The subnet id can be anyone of the three private subnets."
  default = ""
}

variable "ami_value" {
  type        = string
  description = "The name of the AMI"
  default = ""
}

variable "standard_sg_rds" {
  type        = string
  description = "The SG of RDS migration DB"
  default = ""
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC ID"
  default = ""
}

variable "aws_current_account_id" {
  type        = string
  description = "The current AWS Account ID"
  default = ""
}