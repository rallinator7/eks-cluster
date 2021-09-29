remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "beeze-terraform"
    key = "beeze-cloud/pre-prod/deployments/jenkins/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-2"
  }
}


generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "jenkins" {
  server_url = "https://jenkins.beeze.co"
  # Use JENKINS_USERNAME env var or SOPS
  # Use JENKINS_PASSWORD env var or SOPS 
}
EOF
}