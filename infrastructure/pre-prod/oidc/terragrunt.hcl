dependency "eks" {
  config_path = "../eks"
}

inputs = {
    cluster_oidc_issuer_url = dependency.eks.outputs.cluster_oidc_issuer_url
}

include {
  path = find_in_parent_folders()
}

generate "variables" {
  path = "variables.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
variable "cluster_oidc_issuer_url" {}
EOF
}