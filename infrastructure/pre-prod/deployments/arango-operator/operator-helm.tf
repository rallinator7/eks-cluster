resource "helm_release" "arangodb_operator" {
  name            = "arangodb-operator"
  namespace       = "arangodb"
  chart           = "./../../../../manifests/global/arangodb-operator"
  wait            = true
  cleanup_on_fail = true

  values = [
    "${file("values.yaml")}"
  ]

  depends_on = [
    helm_release.arangodb_crds
  ]
}