resource "vault_identity_group" "markets_admins_groups" {
  for_each = toset(distinct(local.markets))
  name     = "vault_admins"
  type     = "internal"
  policies = ["default", "vault_admins_policy"]
  namespace = "secrets/${each.value}"
  member_group_ids = var.parent_group_id_list
  depends_on = [ resource.vault_namespace.markets_namespaces, resource.vault_policy.markets_policies ]
}

resource "vault_identity_group" "areas_admins_groups" {
  for_each = toset(distinct(local.areas))
  name     = "vault_admins"
  type     = "internal"
  policies = ["default", "vault_admins_policy"]
  namespace = each.value
  member_group_ids = var.parent_group_id_list
  depends_on = [ resource.vault_namespace.areas_namespaces, resource.vault_policy.areas_policies ]
}

resource "vault_identity_group" "projects_admins_groups" {
  for_each = toset(distinct(local.projects))
  name     = "vault_admins"
  type     = "internal"
  policies = ["default", "vault_admins_policy"]
  namespace = each.value
  member_group_ids = var.parent_group_id_list
  depends_on = [ resource.vault_namespace.project_namespaces, resource.vault_policy.projects_policies ]
}

resource "vault_identity_group" "envs_admins_groups" {
  for_each = toset(distinct(var.tenants_list))
  name     = "vault_admins"
  type     = "internal"
  policies = ["default", "vault_admins_policy"]
  namespace = each.value
  member_group_ids = var.parent_group_id_list
  depends_on = [ resource.vault_namespace.env_namespaces, resource.vault_policy.env_policies ]
}