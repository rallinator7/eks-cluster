resource "helm_release" "external_dns" {
  name            = "external-dns"
  namespace       = "default"
  chart           = "./../../../../manifests/global/external-dns"
  wait            = true
  cleanup_on_fail = true

  values = [
    "${file("values.yaml")}"
  ]
}