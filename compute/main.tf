module "identity" {
  source                 = "../identity"
  aws_current_account_id = var.aws_current_account_id
}

module "security" {
  source          = "../security"
  standard_sg_rds = var.standard_sg_rds
  vpc_id          = var.vpc_id
}

resource "aws_instance" "my_instance" {
  ami                    = data.aws_ami.my_instance.id
  instance_type          = "m6g.4xlarge"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.security.security_group_custom_id]
  iam_instance_profile   = module.identity.aws_rds_custom_instance_role_for_rds_name

  tags = {
    Name             = "Oracle Migration"
    backup           = "Daily"
    Environment      = "Dev"
    Application_ID   = "0000000"
    Tech_Owner       = "Patrick Richter"
  }

}