module "compute" {
  source                 = "../compute"
  aws_current_account_id = var.aws_current_account_id
  ami_value              = var.ami_value
  subnet_id              = var.subnet_id
  standard_sg_rds        = var.standard_sg_rds
  vpc_id                 = var.vpc_id
}

resource "aws_ebs_volume" "ebs_volume_my_instance" {
  availability_zone = "eu-central-1a"
  provider          = aws
  size              = 1000
  type              = "gp2"
}

resource "aws_volume_attachment" "volume_attachement_my_instance" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_volume_my_instance.id
  instance_id = module.compute.instance_id
}

resource "aws_ebs_snapshot" "my_instance_snapshot" {
  volume_id              = aws_ebs_volume.ebs_volume_my_instance.id
  temporary_restore_days = 7

 tags = {
    Name             = "Oracle Migration"
    backup           = "Daily"
    Environment      = "Dev"
    Application_ID   = "0000000"
    Tech_Owner       = "Patrick Richter"
  }
}
