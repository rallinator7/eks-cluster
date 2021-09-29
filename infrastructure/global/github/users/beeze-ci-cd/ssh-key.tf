resource "github_user_ssh_key" "beeze_ci_cd" {
  title = "beeze-ci-cd-pub"
  key   = "${file("beeze_rsa.pub")}"
}