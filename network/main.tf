resource "aws_db_subnet_group" "db_subnet_custom" {
  name       = "dbsubnetcustom"
  subnet_ids = [var.subnet_group_id_1, var.subnet_group_id_2]

   tags = {
    Name             = "Oracle Migration"
    backup           = "Daily"
    Environment      = "Dev"
    Application_ID   = "0000000"
    Tech_Owner       = "Patrick Richter"
  }
}