terraform {
  required_version = ">= 0.14"

  required_providers {
    random   = "~> 2.1"
    local    = "~> 1.2"
    null     = "~> 2.1"
    template = "~> 2.1"
    jenkins = {
      source  = "taiidani/jenkins"
      version = "0.7.0-beta2"
    }
  }
}