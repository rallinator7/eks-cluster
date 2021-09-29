dependency "eks" {
  config_path = "../../../../eks"
}

dependency "oidc" {
  config_path = "../../../../oidc"
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