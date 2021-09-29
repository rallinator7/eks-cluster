module "cert_manager" {
  source = "git@github.com:Beeze-Co/beeze-cloud.git//infrastructure/modules/sa-iam-role-link"

  role = {
    name        = "cert-manager"
    description = "Gives Cert-Manager access to Route53"

    tags = {
      "ServiceAccount" = "cert-manager"
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
        "${regex("oidc[.]eks[.].+", var.cluster_oidc_arn)}:sub": "system:serviceaccount:kube-system:cert-manager"
        }
    }
    }
  ]
}

EOT

  }

  role_policy = {
    name        = "cert-manager-policy"
    description = "policy for  cert-manager role"
    policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "route53:GetChange",
      "Resource": "arn:aws:route53:::change/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets",
        "route53:ListResourceRecordSets"
      ],
      "Resource": "arn:aws:route53:::hostedzone/*"
    },
    {
      "Effect": "Allow",
      "Action": "route53:ListHostedZonesByName",
      "Resource": "*"
    }
  ]
}

EOF
  }
}
