remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "beeze-terraform"
    key = "beeze-cloud/global/github/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-2"
  }
}