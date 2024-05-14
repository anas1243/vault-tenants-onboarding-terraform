resource "vault_namespace" "markets_namespaces" {
    for_each = toset(distinct(local.markets))
    namespace = "secrets"
    path = each.value
    depends_on = [ var.parent_group_id_list ]
}

resource "vault_namespace" "areas_namespaces" {
  for_each = toset(distinct(local.areas))
  namespace = join("/", slice(split("/",each.value),0,2))
  path = join("/", slice(split("/",each.value),2,3))
  depends_on = [ vault_namespace.markets_namespaces ]
}

resource "vault_namespace" "project_namespaces" {
  for_each = toset(distinct(local.projects))
  namespace = join("/", slice(split("/",each.value),0,3))
  path = join("/", slice(split("/",each.value),3,4))
  depends_on = [ vault_namespace.areas_namespaces ]
}

resource "vault_namespace" "env_namespaces" {
  for_each = toset(var.tenants_list)
  namespace = join("/", slice(split("/",each.value),0,4))
  path = join("/", slice(split("/",each.value),4,5))
  depends_on = [ vault_namespace.project_namespaces ]
}