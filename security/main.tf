resource "aws_kms_key" "custom_migration_external_provider" {
  description = "custom_migration_external_provider"
}

resource "aws_kms_alias" "custom_migration_external_provider" {
  name          = "alias/custom_provider_rds_custom_key"
  target_key_id = aws_kms_key.custom_migration_external_provider.key_id
}

# Add an ingress rule to allow traffic on port 1531 for customEc2 to RDS
resource "aws_security_group_rule" "allow_1531_custom_rds" {
  type        = "ingress"
  from_port   = 1531
  to_port     = 1531
  protocol    = "tcp"
  cidr_blocks = ["20.100.100.0/24"]

  security_group_id = data.aws_security_group.standard_sg.id
}

resource "aws_security_group" "custom_migration_rules" {
  name        = "custom_migration_rules"
  description = "Allow SSH/ICMP ingresss and everything egress for external_provider cidr range"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.external_provider_cidr]
  }

  ingress {
    description = "ICMP from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [var.external_provider_cidr]
  }

  ingress {
    description = "VNC Viewer access"
    from_port   = 5901
    to_port     = 5909
    protocol    = "tcp"
    cidr_blocks = [var.external_provider_cidr]
  }

  ingress {
    description = "external_provider migration"
    from_port   = 7011
    to_port     = 7012
    protocol    = "tcp"
    cidr_blocks = ["20.100.100.0/16", "20.000.000.0/20"]
  }

  ingress {
    description = "external_provider migration"
    from_port   = 1531
    to_port     = 1531
    protocol    = "tcp"
    cidr_blocks = ["20.100.100.0/16", "20.000.000.0/20"]
  }

  ingress {
    description = "external_provider migration"
    from_port   = 7001
    to_port     = 7002
    protocol    = "tcp"
    cidr_blocks = ["20.100.100.0/24", "20.000.000.0/20"]
  }

  ingress {
    description = "external_provider migration"
    from_port   = 5901
    to_port     = 5910
    protocol    = "tcp"
    cidr_blocks = ["20.100.100.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

 tags = {
    Name             = "Oracle Migration"
    backup           = "Daily"
    Environment      = "Dev"
    Application_ID   = "0000000"
    Tech_Owner       = "Patrick Richter"
  }
}