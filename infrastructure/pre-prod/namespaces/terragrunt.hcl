dependency "oidc" {
  config_path = "../oidc"
}

dependency "eks" {
  config_path = "../eks"
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

inputs= {
    eks_cluster_endpoint = dependency.eks.outputs.eks_cluster_endpoint
    eks_cluster_certificate = dependency.eks.outputs.eks_cluster_certificate
    cluster_oidc_arn = dependency.oidc.outputs.cluster_oidc_arn
    cluster_name = dependency.eks.outputs.cluster_name
}

include {
  path = find_in_parent_folders()
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
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
EOF
}