terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.10.0"
    }
  }
}

module "compute" {
  source                 = "./compute"
  aws_current_account_id = var.aws_current_account_id
  ami_value              = var.ami_value
  subnet_id              = var.subnet_id
  standard_sg_rds        = var.standard_sg_rds
  vpc_id                 = var.vpc_id
}

module "filestore" {
  source = "./filestore"
}

module "identity" {
  source                 = "./identity"
  aws_current_account_id = var.aws_current_account_id
}

module "security" {
  source          = "./security"
  standard_sg_rds = var.standard_sg_rds
  vpc_id          = var.vpc_id
}

module "network" {
  source            = "./network"
  subnet_group_id_1 = var.subnet_group_id_1
  subnet_group_id_2 = var.subnet_group_id_2
}