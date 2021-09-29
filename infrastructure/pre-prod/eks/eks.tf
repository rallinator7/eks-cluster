module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.18"
  subnets         = var.private_subnets[*]

  vpc_id = var.vpc_id

  worker_groups = [
    {
      name                          = "linux-eks-group"
      instance_type                 = "t3.large"
      asg_desired_capacity          = 3
      root_volume_size              = "100"
      root_volume_type              = "gp2"
      additional_security_group_ids = [aws_security_group.linux_group.id]
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}