module "sops_secrets_operator" {
  source = "git@github.com:Beeze-Co/beeze-cloud.git//infrastructure/modules/sa-iam-role-link"

  role = {
    name        = "sops-secrets-operator"
    description = "Used for connecting Sops Secrets Operator with KMS Keys"
    tags = {
      "ServiceAccount" = "sops-secrets-operator"
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
        "${regex("oidc[.]eks[.].+", var.cluster_oidc_arn)}:sub": "system:serviceaccount:sops:sops-secrets-operator"
        }
    }
    }
  ]
}

EOT

  }

  role_policy = {
    name        = "sops-secrets-operator-policy"
    description = "policy for Sops secrets operator"
    policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "kms:DescribeCustomKeyStores",
                "kms:ListKeys",
                "kms:DeleteCustomKeyStore",
                "kms:GenerateRandom",
                "kms:UpdateCustomKeyStore",
                "kms:ListAliases",
                "kms:DisconnectCustomKeyStore",
                "kms:CreateKey",
                "kms:ConnectCustomKeyStore",
                "kms:CreateCustomKeyStore"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "kms:*",
            "Resource": "*"
        }
    ]
}
  EOF
  }
}