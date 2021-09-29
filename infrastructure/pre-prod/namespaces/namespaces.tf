resource "kubernetes_namespace" "e2e" {
  metadata {
    name = "e2e"
  }
}

resource "kubernetes_namespace" "mailu" {
  metadata {
    name = "mailu"
  }
}