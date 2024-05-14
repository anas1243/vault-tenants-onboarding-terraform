variable "kms_namespaces" {
  type = list
}

variable "identity_group" {
  type = object({
    group_name = string
    group_type = string
  })
  validation {
    condition     = can(regex("^(external|internal)$", var.identity_group.group_type))
    error_message = "Group type must be external or internal"
  }
}
variable "parent_group_id_list" {
  type = list
}
