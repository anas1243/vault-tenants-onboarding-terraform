variable "kms_tenants" {
  type = list(string)
}

variable "tenants_internal_group" {
  type = object({
    group_name = string
    group_type = string
  })
  validation {
    condition     = can(regex("^(external|internal)$", var.tenants_internal_group.group_type))
    error_message = "Group type must be external or internal"
  }
}

data "vault_identity_group" "parent_identity_group" {
  group_name = "vault-admins"
  namespace = "kms"
}