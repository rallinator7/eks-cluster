terraform {
  required_version = ">= 0.14"

  required_providers {
    random   = "~> 2.1"
    local    = "~> 1.2"
    null     = "~> 2.1"
    template = "~> 2.1"
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.2"
    }
  }
}