resource "opentelekomcloud_compute_keypair_v2" "import-keypair" {
  name       = "playground_ecdsa"
  #public_key = file("${path.module}/playground_ecdsa.pub") 
  public_key = file("/Users/A106026934/.ssh/playground_ecdsa.pub")
}

output "key_name" {
  value = opentelekomcloud_compute_keypair_v2.import-keypair.name
}
