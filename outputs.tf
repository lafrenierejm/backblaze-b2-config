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
