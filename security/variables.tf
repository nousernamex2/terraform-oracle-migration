variable "standard_sg_rds" {
  type        = string
  description = "The SG of RDS migration DB"
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC ID"
}

variable "external_provider_cidr" {
  type        = string
  description = "The current AWS Account ID"
  default     = "20.100.100.0/24"
}