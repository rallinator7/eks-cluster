module "ebs_csi_driver" {
  source = "git@github.com:Beeze-Co/beeze-cloud.git//infrastructure/modules/sa-iam-role-link"

  role = {
    name        = "ebs-csi-driver"
    description = "Used for creating,assigning, and snapshotting ebs volumes for pods"

    tags = {
      "ServiceAccount1" = "ebs-csi-controller-sa"
      "ServiceAccount2" = "ebs-snapshot-controller"
      "Cluster"         = var.cluster_name
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
        "${regex("oidc[.]eks[.].+", var.cluster_oidc_arn)}:sub": [
            "system:serviceaccount:kube-system:ebs-csi-controller-sa",
            "system:serviceaccount:kube-system:ebs-snapshot-controller"
            ]
        }
    }
    }
  ]
}

EOT

  }

  role_policy = {
    name        = "ebs-csi-driver-policy"
    description = "policy for ebs csi driver role"
    policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AttachVolume",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteSnapshot",
        "ec2:DeleteTags",
        "ec2:DeleteVolume",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeInstances",
        "ec2:DescribeSnapshots",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DescribeVolumesModifications",
        "ec2:DetachVolume",
        "ec2:ModifyVolume"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  }
}
