resource "helm_release" "strimzi_kafka_operator" {
  name             = "strimzi-kafka-operator"
  namespace        = "strimzi"
  create_namespace = true
  chart            = "./../../../../manifests/pre-prod/strimzi-operator"
  wait             = true
  cleanup_on_fail  = true

  values = [
    "${file("values.yaml")}"
  ]
}