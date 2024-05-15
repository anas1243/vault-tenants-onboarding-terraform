

module "landing_zone_kms" {
  source               = "../modules/landing_zone_kms"
  kms_namespaces       = var.kms_tenants
  parent_group_id_list = [data.vault_identity_group.parent_identity_group.group_id, vault_identity_group.external_group_ldap.id]
  identity_group       = var.tenants_internal_group
  depends_on           = [data.vault_identity_group.parent_identity_group]
}



# docker run -p 6443:443 \
#         --env PHPLDAPADMIN_LDAP_HOSTS=ec2-18-135-17-65.eu-west-2.compute.amazonaws.com \
#         --detach osixia/phpldapadmin:0.9.0
