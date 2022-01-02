generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 0.13"
  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "~> 0.2"
    }
  }
}

provider "b2" {
}
EOF
}

inputs = {
  buckets = [
    "imac-bralley-xyz",
    "macbook-air-lafreniere-xyz",
  ]
}
