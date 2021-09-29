resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true
  chart            = "./../../../../manifests/pre-prod/argocd"
  wait             = true
  cleanup_on_fail  = true

  values = [
    "${file("values.yaml")}"
  ]
}