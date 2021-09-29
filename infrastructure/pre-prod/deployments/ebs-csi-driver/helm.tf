resource "helm_release" "ebs_csi_driver" {
  name            = "ebs-csi-driver"
  namespace       = "kube-system"
  chart           = "./../../../../manifests/global/aws-ebs-csi-driver"
  wait            = true
  cleanup_on_fail = true

  values = [
    "${file("values.yaml")}"
  ]
}