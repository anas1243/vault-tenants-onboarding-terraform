terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
}