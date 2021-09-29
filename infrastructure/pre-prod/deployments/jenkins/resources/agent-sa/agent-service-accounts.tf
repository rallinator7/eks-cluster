module "push_pull_ecr" {
  source = "git@github.com:Beeze-Co/beeze-cloud.git//infrastructure/modules/sa-iam-role-link"

  role = {
    name        = "push-pull-ecr"
    description = "Allows for jenkins agents to push and pull private images from ECR"

    tags = {
      "ServiceAccount" = "push-pull-ecr"
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
          "${regex("oidc[.]eks[.].+", var.cluster_oidc_arn)}:sub": "system:serviceaccount:jenkins:push-pull-ecr"
        }
    }
    }
  ]
}

EOT

  }

  role_policy = {
    name        = "push-pull-ecr"
    description = "Allows for jenkins agents to push and pull from private ecr"
    policy      = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
      ],
      "Resource": "*"
    }
  ]
}
EOF

  }
}

module "pull_image_secret_generator" {
  source = "git@github.com:Beeze-Co/beeze-cloud.git//infrastructure/modules/sa-iam-role-link"

  role = {
    name        = "pull-image-secret-generator"
    description = "Allows for jenkins to get ECR Login"

    tags = {
      "ServiceAccount" = "pull-image-secret-generator"
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
          "${regex("oidc[.]eks[.].+", var.cluster_oidc_arn)}:sub": "system:serviceaccount:jenkins:pull-image-secret-generator"
        }
    }
    }
  ]
}

EOT

  }

  role_policy = {
    name        = "pull-image-secret-generator"
    description = "Allows for jenkins agents to push and pull from private ecr"
    policy      = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
      ],
      "Resource": "*"
    }
  ]
}
EOF

  }
}