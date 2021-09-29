resource "helm_release" "cert_manager" {
  name            = "cert-manager"
  namespace       = "kube-system"
  chart           = "./../../../../manifests/global/cert-manager"
  wait            = true
  cleanup_on_fail = true

  values = [
    "${file("values.yaml")}"
  ]

  depends_on = [
    kubectl_manifest.crds
  ]
}