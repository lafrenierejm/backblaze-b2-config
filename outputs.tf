output "application_key_id" {
  value = {
    for k, v in data.b2_application_key.key :
    k => v.id
  }
}

output "application_key" {
  value = {
    for k, v in b2_application_key.key :
    k => v.application_key
  }
  sensitive = true
}

output "s3_access_key_id" {
  description = "S3-compatible access key ID (B2 application key ID) per bucket."
  value = {
    for k, v in b2_application_key.key :
    k => v.application_key_id
  }
}

output "s3_secret_access_key" {
  description = "S3-compatible secret access key (B2 application key) per bucket."
  value = {
    for k, v in b2_application_key.key :
    k => v.application_key
  }
  sensitive = true
}
