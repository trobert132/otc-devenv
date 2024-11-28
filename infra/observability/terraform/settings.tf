# This file has been generated from ./tf_backend/main.tf:null_resource
terraform {
  required_version = "<=1.9.0, >=v1.4.6"
  backend "s3" {
    endpoint                    =  "obs.eu-de.otc.t-systems.com"          
    bucket                      = "tothr-dev-tfstate"
    key                         = "personal/obs-services"
    skip_region_validation      = true
    skip_credentials_validation = true
    region                      = "eu-de"
   }
   required_providers {
     opentelekomcloud = {
     source  = "opentelekomcloud/opentelekomcloud"
     version = ">=1.36.25"
     }
   }
}
