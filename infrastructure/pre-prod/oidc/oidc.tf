data "tls_certificate" "oidc_certs" {
  url = var.cluster_oidc_issuer_url
}

resource "aws_iam_openid_connect_provider" "cluster_oidc" {
  url             = var.cluster_oidc_issuer_url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc_certs.certificates.0.sha1_fingerprint]
}