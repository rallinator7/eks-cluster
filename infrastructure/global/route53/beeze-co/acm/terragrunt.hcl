dependency "hosted-zone" {
  config_path = "../hosted-zone"
}

inputs = {
  zone_name = dependency.hosted-zone.outputs.zone_name
  zone_id = dependency.hosted-zone.outputs.zone_id
}

generate "variables" {
  path = "variables.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
variable "zone_name" {}

variable "zone_id" {}
EOF
}

include {
  path = find_in_parent_folders()
}