terraform {
  required_version = ">= 0.14"

  required_providers {
    random   = "~> 2.1"
    local    = "~> 1.2"
    null     = "~> 2.1"
    template = "~> 2.1"
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.22.0"
    }
  }
}

locals {
  vpc_name     = "beeze-pre-prod-vpc"
  cluster_name = "beeze-pre-prod-eks"
}