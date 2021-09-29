resource "helm_release" "sops_secrets_operator" {
  name             = "sops-secrets-operator"
  namespace        = "sops"
  create_namespace = true
  chart            = "./../../../../manifests/global/sops-secrets-operator"
  wait             = true
  cleanup_on_fail  = true

  values = [
    "${file("values.yaml")}"
  ]
}