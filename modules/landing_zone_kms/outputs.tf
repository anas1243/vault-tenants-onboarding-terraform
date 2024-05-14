/* 
This module returns a list of namespaces that are created
*/
output "namespaces_path" {
  value = [for key, namespace in resource.vault_namespace.tenants_namespaces : namespace.path_fq]

}