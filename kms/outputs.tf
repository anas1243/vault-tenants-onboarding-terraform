output "namespaces" {
  value = module.landing_zone_kms.namespaces_path
}
output "parent_group_id" {
  value = data.vault_identity_group.parent_identity_group.group_id
}