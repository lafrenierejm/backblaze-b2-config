terraform {
  required_version = "~> 1.10"
  required_providers {
    b2 = {
      source  = "registry.opentofu.org/backblaze/b2"
      version = "~> 0.12"
    }
  }
}

provider "b2" {
}
