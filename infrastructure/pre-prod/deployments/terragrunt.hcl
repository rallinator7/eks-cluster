remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "beeze-terraform"
    key = "beeze-cloud/pre-prod/deployments/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-2"
  }
}

generate "variables" {
  path = "variables.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
variable "cluster_oidc_arn" {}

variable "cluster_name" {}

variable "eks_cluster_endpoint" {}

variable "eks_cluster_certificate" {}
EOF
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region  = "us-east-2"
}

provider "kubernetes" {
  host                   = var.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.eks_cluster_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      var.cluster_name
    ]
  }
}

provider "helm" {
  kubernetes {
    host                   = var.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(var.eks_cluster_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      command     = "aws"
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        var.cluster_name
      ]
    }
  }
}
EOF
}