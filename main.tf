resource "b2_bucket" "bucket" {
  for_each = var.buckets

  bucket_name = each.value
  bucket_type = "allPrivate"
}

resource "b2_application_key" "key" {
  for_each = b2_bucket.bucket

  key_name     = each.value.bucket_name
  bucket_id    = each.value.id
  capabilities = var.key_capabilities
}

data "b2_application_key" "key" {
  for_each = b2_application_key.key

  key_name = each.value.key_name
}
