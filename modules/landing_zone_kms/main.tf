resource "vault_namespace" "tenants_namespaces" {
for_each  = toset(var.kms_namespaces)
  namespace = "kms"
  path      = each.value
}

resource "vault_policy" "admin_policy" {
  for_each = toset(var.kms_namespaces)
  namespace = "kms/${each.value}"
  name = "${each.value}_admin_policy"
  policy = <<EOF
path "${each.value}_secrets/*"{
 capabilities = ["create", "update", "patch", "delete", "read", "list"]
}

path "${each.value}_transit/*"{
 capabilities = ["create", "update", "patch", "delete", "read", "list"]
}

# Manage namespaces in the current level
path "sys/namespaces/*" {
  capabilities = ["create", "update", "patch", "delete", "read", "list"]
}

# Create and manage identities (entities, aliases, lookup, identity tokens, OIDC)
path "identity/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

# Manage ACL policies in the current level
path "sys/policies/acl/*" {
  capabilities = ["read", "create", "update", "delete", "list"]
}

# List auth methods in the current level
path "sys/auth" {
  capabilities = ["read"]
}

# Enable, disable, and read auth methods in the current level
path "sys/auth/*" {
  capabilities = ["read", "create", "update", "delete", "sudo"]
}

# Configure Auth methods and CRUD Auth methods' roles in the current level
path "auth/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Enable and Disable engines
path "sys/mounts/*" {
 capabilities = ["read", "create", "update", "delete", "sudo", "list"]
}

# List Engines in the CLI
#If you want to view Engines in the UI you must specify the path in a separate policy path "secrets/*"
path "sys/mounts" {
 capabilities = ["read"]
}

# Configure userpass, approle, etc.. auth methods
path "sys/mounts/auth/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF
depends_on = [ resource.vault_namespace.tenants_namespaces ]
}

resource "vault_identity_group" "admins_identity_group" {
  for_each = toset(var.kms_namespaces)
  name     = var.identity_group.group_name
  type     = var.identity_group.group_type
  policies = ["default", "${each.value}_admin_policy"]
  namespace = "kms/${each.value}"
  member_group_ids = var.parent_group_id_list
  depends_on = [ resource.vault_namespace.tenants_namespaces, resource.vault_policy.admin_policy ]
}