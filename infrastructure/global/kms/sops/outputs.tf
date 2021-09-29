output "sops_key_id" {
  value = aws_kms_key.sops_key.key_id
}

output "sops_key_arn" {
  value = aws_kms_key.sops_key.arn
}

output "sops_key_alias" {
  value = aws_kms_alias.sops_key_alias.name
}

output "sops_key_policy" {
  value = aws_kms_key.sops_key.policy
}