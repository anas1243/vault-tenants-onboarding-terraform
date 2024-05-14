resource "vault_policy" "markets_policies" {
  for_each = toset(local.markets)
  namespace = "secrets/${each.value}"
  name = "vault_admins_policy"
  policy = <<EOF
# Manage namespaces in the secrets level
path "sys/namespaces/*" {
  capabilities = ["create", "update", "patch", "delete", "read", "list"]
}

# Create and manage identities (entities, aliases, lookup, identity tokens, OIDC) in the kms parent level
path "identity/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

# Manage ACL policies in the secrets parent level
path "sys/policies/acl/*" {
  capabilities = ["read", "create", "update", "delete", "list"]
}
EOF
depends_on = [ vault_namespace.markets_namespaces ]
}

resource "vault_policy" "areas_policies" {
  for_each = toset(local.areas)
  namespace = each.value
  name = "vault_admins_policy"
  policy = <<EOF
# Manage namespaces in the secrets level
path "sys/namespaces/*" {
  capabilities = ["create", "update", "patch", "delete", "read", "list"]
}

# Create and manage identities (entities, aliases, lookup, identity tokens, OIDC) in the kms parent level
path "identity/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

# Manage ACL policies in the secrets parent level
path "sys/policies/acl/*" {
  capabilities = ["read", "create", "update", "delete", "list"]
}
EOF
depends_on = [ vault_namespace.areas_namespaces ]
}

resource "vault_policy" "projects_policies" {
  for_each = toset(local.projects)
  namespace = each.value
  name = "vault_admins_policy"
  policy = <<EOF
# Manage namespaces in the secrets level
path "sys/namespaces/*" {
  capabilities = ["create", "update", "patch", "delete", "read", "list"]
}

# Create and manage identities (entities, aliases, lookup, identity tokens, OIDC) in the kms parent level
path "identity/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

# Manage ACL policies in the secrets parent level
path "sys/policies/acl/*" {
  capabilities = ["read", "create", "update", "delete", "list"]
}
EOF
depends_on = [ vault_namespace.project_namespaces ]
}

resource "vault_policy" "env_policies" {
  for_each = toset(var.tenants_list)
  namespace = each.value
  name = "vault_admins_policy"
  policy = <<EOF
# Manage namespaces in the current level
path "sys/namespaces/*" {
  capabilities = ["update", "read", "list"]
}

# Manage secrets in the current level
path "secrets/*" {
  capabilities = ["create", "update", "read", "delete", "list", "patch"]
}
# Manage secrets in the current level
path "kv/*" {
  capabilities = ["create", "update", "read", "delete", "list", "patch"]
}
# Manage transit in the current level
path "transit/*" {
  capabilities = ["create", "update", "read", "delete", "list", "patch"]
}

# Manage database engine in the current level
path "database/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
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
depends_on = [ vault_namespace.env_namespaces ]
}