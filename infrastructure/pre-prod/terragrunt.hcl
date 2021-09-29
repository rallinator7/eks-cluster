remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "beeze-terraform"
    key = "beeze-cloud/pre-prod/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-2"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region  = "us-east-2"
}
EOF
}
