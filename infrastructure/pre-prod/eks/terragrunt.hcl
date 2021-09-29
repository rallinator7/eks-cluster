dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  private_subnets = dependency.vpc.outputs.private_subnets
  cluster_name = dependency.vpc.outputs.cluster_name
}

include {
  path = find_in_parent_folders()
}

generate "variables" {
  path = "variables.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
variable "vpc_id" {}

variable "private_subnets" {
    type = list(string)
}

variable "cluster_name" {}

EOF
}