dependency "credentials" {
  config_path = "../credentials"
  skip_outputs=true
}

include {
  path = find_in_parent_folders()
}