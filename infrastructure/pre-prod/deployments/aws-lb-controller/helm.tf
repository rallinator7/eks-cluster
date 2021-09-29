resource "helm_release" "aws_load_balancer_controller" {
  name            = "aws-load-balancer-controller"
  namespace       = "kube-system"
  chart           = "./../../../../manifests/global/aws-lb-controller"
  wait            = true
  cleanup_on_fail = true

  values = [
    "${file("values.yaml")}"
  ]

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
}