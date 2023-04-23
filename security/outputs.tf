output "kms_key_id" {
  value = aws_kms_key.custom_migration_external_provider.id
}

output "security_group_custom_id" {
  value = aws_security_group.custom_migration_rules.id
}