locals {
  regex = "[^A-Za-z-]"
  name = join(
    "-",
    [
      replace(var.host.hostname, local.regex, "-"),
      replace(var.host.domain, local.regex, "-")
    ]
  )
}

resource "b2_bucket" "bucket" {
  bucket_name = local.name
  bucket_type = "allPrivate"
}

resource "b2_application_key" "key" {
  key_name     = local.name
  bucket_id    = b2_bucket.bucket.id
  capabilities = var.key_capabilities
}

data "b2_application_key" "key" {
  key_name = b2_application_key.key.key_name
}
