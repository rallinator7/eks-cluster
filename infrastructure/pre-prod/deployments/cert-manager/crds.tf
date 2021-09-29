data "kubectl_file_documents" "manifests" {
  content = file("./cert-manager.crds.yaml")
}

resource "kubectl_manifest" "crds" {
  count     = length(data.kubectl_file_documents.manifests.documents)
  yaml_body = element(data.kubectl_file_documents.manifests.documents, count.index)

  wait = true
}