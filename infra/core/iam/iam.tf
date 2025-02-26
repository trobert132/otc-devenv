data "opentelekomcloud_identity_role_v3" "role_operateaccess" {
  name = "system_all_31" # OBS OperateAccess
}

# Create the User Group
resource "opentelekomcloud_identity_group_v3" "tothr_test_obs_group" {
  name = "tothr_test_obs_group"
  description = "User group with OBS rwx permissions"
}

## Create a test Role (optional)
#resource "opentelekomcloud_identity_role_v3" "tothr_test_role" {
#  description   = "Programmatic test access to Bucket"
#  display_name  = "tothr_test_role"
#  display_layer = "domain"
#  statement {
#    effect    = "Allow"
#    action    = ["obs:bucket:GetBucketAcl"]
#    resource  = ["OBS:*:*:bucket:tothr-test_bucket"]
#    condition = <<EOF
#    {
#      "StringStartWith": {
#        "g:ProjectName": [
#          "eu-nl"
#        ]
#      },
#      "StringNotEqualsIgnoreCase": {
#        "g:ServiceName": [
#          "iam"
#        ]
#      }
#    }
#    EOF
#  }
#  statement {
#    effect = "Allow"
#    action = [
#      "obs:bucket:HeadBucket",
#      "obs:bucket:ListBucketMultipartUploads",
#      "obs:bucket:ListBucket"
#    ]
#  }
#}
#
# Assign Role to group
resource "opentelekomcloud_identity_role_assignment_v3" "role_assignment" {
  group_id  = opentelekomcloud_identity_group_v3.tothr_test_obs_group.id
  domain_id = var.domain_id
  role_id   = data.opentelekomcloud_identity_role_v3.role_operateaccess.id
  all_projects = true
  #role_id = opentelekomcloud_identity_role_v3.tothr_test_role.id
}

# Create the User
resource "opentelekomcloud_identity_user_v3" "tothr_test_obs_user" {
  name = "tothr_test_obs_user"
  description = "User for OBS bucket operations"
  enabled = true
}

# Add the User to the Group
resource "opentelekomcloud_identity_group_membership_v3" "tothr_test_bucket_membership" {
  group = opentelekomcloud_identity_group_v3.tothr_test_obs_group.id
  users = [opentelekomcloud_identity_user_v3.tothr_test_obs_user.id]
}

# Create Access Key/Secret Key (AK/SK) for the User
resource "opentelekomcloud_identity_credential_v3" "tothr_test_bucket_aksk" {
  user_id = opentelekomcloud_identity_user_v3.tothr_test_obs_user.id
  lifecycle {
    # Prevent unintentional updates
    prevent_destroy = false
  }
}

resource "kubernetes_namespace" "tothr_obs_test" {
  metadata {
    name = "tothr-obs-test"
  }
}

resource "kubernetes_secret" "obs_secret" {
  metadata {
    labels = {
      "secret.kubernetes.io/used-by" = "csi"
    }
    name      = "tothr-obs-secret"
    namespace = "tothr-obs-test"
    annotations = {
      "kubectl.kubernetes.io/last-applied-configuration" = jsonencode({
        apiVersion = "v1"
        kind       = "Secret"
        metadata   = {
          name      = "tothr-obs-secret"
          namespace = "tothr-obs-test"
        }
        data = {
          access_key = opentelekomcloud_identity_credential_v3.tothr_test_bucket_aksk.access
          secret_key = opentelekomcloud_identity_credential_v3.tothr_test_bucket_aksk.secret
        }
      })
    }
  }

  data = {
    # access.key and secret.key should be used despite terraform not liking '.' when it comes to naming conventions.
    # to circumvent errors, the keys should be closed between quotes
    "access.key" = opentelekomcloud_identity_credential_v3.tothr_test_bucket_aksk.access
    "secret.key" = opentelekomcloud_identity_credential_v3.tothr_test_bucket_aksk.secret
  }

  lifecycle {
    ignore_changes = [ metadata[0].annotations, ] # is needed in order to avoid Terraform's attempt to reconcile changes to annotations during subsequent applies
  }

  type = "cfe/secure-opaque"  # Set the type to 'cfe/secure-opaque' as everest driver complains if only opaque is used
  
  depends_on = [opentelekomcloud_identity_credential_v3.tothr_test_bucket_aksk]
}
