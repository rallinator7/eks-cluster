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
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.10.0"
    }
  }
}

provider "kubectl" {
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