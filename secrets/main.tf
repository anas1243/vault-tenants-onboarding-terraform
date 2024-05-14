module "landing_zone_secrets" {
  source = "../modules/landing_zone_secrets"
  tenants_list = var.tenants_list
  parent_group_id_list = [ data.vault_identity_group.secrets_admin_group.group_id ]
}
