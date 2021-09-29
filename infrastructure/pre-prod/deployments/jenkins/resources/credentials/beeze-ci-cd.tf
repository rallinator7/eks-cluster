data "sops_file" "beeze_ci_cd_password" {
  source_file = "./beeze-ci-cd-oauth-token.enc.yaml"
}

resource "jenkins_credential_username" "beeze_ci_cd" {
  name     = "beeze-ci-cd"
  username = "beeze-ci-cd"
  password = data.sops_file.beeze_ci_cd_password.data["token"]
}