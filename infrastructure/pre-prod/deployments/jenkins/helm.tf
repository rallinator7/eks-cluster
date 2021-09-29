resource "helm_release" "jenkins" {
  name             = "jenkins"
  namespace        = "jenkins"
  create_namespace = true
  chart            = "./../../../../manifests/pre-prod/jenkins"
  wait             = true
  cleanup_on_fail  = true

  values = [
    "${file("values.yaml")}"
  ]
}