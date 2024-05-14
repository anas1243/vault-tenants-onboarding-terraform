module "landing_zone_kms" {
  source = "../modules/landing_zone_kms"
  kms_namespaces = var.kms_tenants
  parent_group_id_list = [data.vault_identity_group.parent_identity_group.group_id]
  identity_group = var.tenants_internal_group
  depends_on = [ data.vault_identity_group.parent_identity_group ]
}
