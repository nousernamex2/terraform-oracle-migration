variable "aws_current_account_id" {
  type        = string
  description = "The current AWS Account ID"
}

variable "iam_roles" {
  type    = set(string)
  default = ["AWSRDSCustom-instance-role-for-rds", "external-providers-admins"]
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}