#output "tothr_test_role" {
#  value = {
#    id           = opentelekomcloud_identity_role_v3.tothr_test_role.id
#    name         = opentelekomcloud_identity_role_v3.tothr_test_role.name
#    description  = opentelekomcloud_identity_role_v3.tothr_test_role.description
#    display_name = opentelekomcloud_identity_role_v3.tothr_test_role.display_name
#  }
#}

output "access_key" {
  value     = opentelekomcloud_identity_credential_v3.tothr_test_bucket_aksk.access
  sensitive = true
}

output "secret_key" {
  value     = opentelekomcloud_identity_credential_v3.tothr_test_bucket_aksk.secret
  sensitive = true
}


