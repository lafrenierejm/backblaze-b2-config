output "bucket_key_ids" {
  description = "IDs of per-bucket application keys."
  value = {
    for k, bucket in b2_bucket.bucket : k => {
      v3 = b2_application_key.v3[k].application_key_id
      v4 = b2_application_key.v4[k].application_key_id
    }
  }
}

output "bucket_keys" {
  description = "Values of per-bucket application keys."
  sensitive   = true
  value = {
    for k, bucket in b2_bucket.bucket : k => {
      v3 = b2_application_key.v3[k].application_key
      v4 = b2_application_key.v4[k].application_key
    }
  }
}
