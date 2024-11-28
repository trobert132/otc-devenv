terraform {
  required_version = "<=1.9.0, >=v1.4.6"
  required_providers {
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = ">=1.36.25"
    }
  }
}
