resource "b2_bucket" "macbook_air" {
  bucket_name = "macbook-air-lafreniere-xyz"
  bucket_type = "allPrivate"
}

resource "b2_application_key" "macbook_air" {
  key_name  = "macbook-air-lafreniere-xyz"
  bucket_id = b2_bucket.macbook_air.id
  capabilities = [
    "deleteFiles",
    "listBuckets",
    "listFiles",
    "readFiles",
    "shareFiles",
    "writeFiles",
  ]
}

data "b2_application_key" "macbook_air" {
  key_name = b2_application_key.macbook_air.key_name
}

output "application_key" {
  value = data.b2_application_key.macbook_air
}

output "application_key_id" {
  value     = b2_application_key.macbook_air.application_key
  sensitive = true
}
