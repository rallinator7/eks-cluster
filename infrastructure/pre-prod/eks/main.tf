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
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.2"
    }
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}