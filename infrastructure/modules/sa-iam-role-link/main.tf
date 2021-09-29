terraform {
  experiments      = [module_variable_optional_attrs]
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

provider "aws" {
  region  = "us-east-2"
}
