resource "jenkins_job" "image_pull_secret_generator" {
  name     = "image-pull-secret-generator"
  template = file("./xml/image-pull-secret-generator.xml")
}