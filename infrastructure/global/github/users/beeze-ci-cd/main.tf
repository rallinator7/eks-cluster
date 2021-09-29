terraform {
  required_version = ">= 0.14"

  required_providers {
    random   = "~> 2.1"
    local    = "~> 1.2"
    null     = "~> 2.1"
    template = "~> 2.1"
    github = {
      source  = "integrations/github"
      version = "4.3.1"
    }
    sops = {
      source = "carlpett/sops"
      version = "0.6.0"
    }
  }
}

data "sops_file" "beeze_ci_cd_oauth_token" {
  source_file = "./beeze-ci-cd-oauth-token.enc.yaml"
}

provider "github" {
  token = data.sops_file.beeze_ci_cd_oauth_token.data["token"]
}

provider "sops" {}