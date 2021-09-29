resource "helm_release" "arangodb_crds" {
  name             = "arangodb-crds"
  namespace        = "arangodb"
  create_namespace = true
  chart            = "./../../../../manifests/global/arangodb-crds"
  wait             = true
  cleanup_on_fail  = true
}