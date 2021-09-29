terraform {
  required_version = ">= 0.14"

  required_providers {
    random   = "~> 2.1"
    local    = "~> 1.2"
    null     = "~> 2.1"
    template = "~> 2.1"
    helm = {
      source  = "hashicorp/helm"
      version = "2.0.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.22.0"
    }
  }
}