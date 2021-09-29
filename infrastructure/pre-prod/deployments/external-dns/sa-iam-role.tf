module "external_dns" {
  source = "git@github.com:Beeze-Co/beeze-cloud.git//infrastructure/modules/sa-iam-role-link"

  role = {
    name        = "external-dns"
    description = "Used for connecting ingresses to Route53"

    tags = {
      "ServiceAccount" = "external-dns"
      "Cluster"        = var.cluster_name
    }

    assume_role_policy = <<EOT
{
  "Version": "2012-10-17",
"Statement": [
    {
    "Effect": "Allow",
    "Principal": {
        "Federated": "${var.cluster_oidc_arn}"
    },
    "Action": "sts:AssumeRoleWithWebIdentity",
    "Condition": {
        "StringEquals": {
        "${regex("oidc[.]eks[.].+", var.cluster_oidc_arn)}:sub": "system:serviceaccount:default:external-dns"
        }
    }
    }
  ]
}

EOT
  }

  role_policy = {
    name        = "external-dns"
    description = "policy for external dns deployment"
    policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
  }
}