
resource "vault_identity_group" "external_group_ldap" {
  namespace                  = "kms"
  name                       = "Admin_Users_from_LDAP"
  type                       = "external"
  external_policies          = true
  external_member_entity_ids = true
  external_member_group_ids  = true
}


resource "vault_identity_group_alias" "ldap-ldap-alias" {
  namespace      = "kms"
  name           = "HashiCorp APP Admins" # must be the EXACT name as the LDAP Group
  mount_accessor = vault_ldap_auth_backend.ldap.accessor
  canonical_id   = vault_identity_group.external_group_ldap.id
}
