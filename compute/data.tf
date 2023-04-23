data "aws_ami" "my_instance" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_value]
  }

  owners = [var.aws_current_account_id]
}

variable "aws_current_account_id" {
  type        = string
  description = "The current AWS Account ID"
}