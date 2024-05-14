variable "tenants_list" {
  type    = list(string)
}

locals {
  markets = [for item in var.tenants_list: split("/", item)[1]]
  areas = [for item in var.tenants_list: join("/",slice(split("/", item),0,3))]
  projects = [for item in var.tenants_list: join("/",slice(split("/", item),0,4))]
}

data "vault_identity_group" "secrets_admin_group" {
  group_name = "vault-admins"
  namespace = "secrets"
}