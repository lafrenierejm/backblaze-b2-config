resource "b2_bucket" "bucket" {
  for_each = var.buckets

  bucket_name = each.value
  bucket_type = "allPrivate"

  default_server_side_encryption {
    mode      = "SSE-B2"
    algorithm = "AES256"
  }

  lifecycle_rules {
    file_name_prefix              = ""
    days_from_hiding_to_deleting  = 1
    days_from_uploading_to_hiding = null
  }
}

resource "b2_application_key" "v3" {
  for_each = b2_bucket.bucket

  key_name     = each.value.bucket_name
  bucket_id    = each.value.id # https://github.com/Backblaze/terraform-provider-b2/pull/132
  capabilities = var.key_capabilities
}

resource "b2_application_key" "v4" {
  for_each = b2_bucket.bucket

  key_name     = each.value.bucket_name
  bucket_ids   = [each.value.id] # https://github.com/Backblaze/terraform-provider-b2/pull/132
  capabilities = var.key_capabilities
}
