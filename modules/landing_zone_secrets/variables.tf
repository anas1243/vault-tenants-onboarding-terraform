variable "tenants_list" {
  type = list(string)
}

locals {
  markets = [for item in var.tenants_list: split("/", item)[1]]
  areas = [for item in var.tenants_list: join("/",slice(split("/", item),0,3))]
  projects = [for item in var.tenants_list: join("/",slice(split("/", item),0,4))]
}

variable "parent_group_id_list" {
  type = list
}