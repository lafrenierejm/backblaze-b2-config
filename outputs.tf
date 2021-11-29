output "application_key_id" {
  value = data.b2_application_key.key.id
}

output "application_key" {
  value     = b2_application_key.key.application_key
  sensitive = true
}
