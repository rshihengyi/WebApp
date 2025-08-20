resource "aws_iam_role" "eks" { # creating control plane
  name = "${local.env}-${local.eks_name}-eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  POLICY
}

resource "aws_iam_role_policy_attachment" "eks" { # attach AmazonEKSClusterPolicy
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.eks.name
}

resource "aws_eks_cluster" "eks" { # actual cluster
    name = "${local.env}-${local.eks_name}"
    version = local.eks_version # use latest version
    role_arn = aws_iam_role.eks.arn # attach iam role to cluster

    vpc_config { # networking settings
      endpoint_private_access = false
      endpoint_public_access = true

      subnet_ids = [
        aws_subnet.private_zone1.id,
        aws_subnet.private_zone2.id
      ]
    }

    access_config { # authentication config
      authentication_mode = "API" # add users to cluster
      bootstrap_cluster_creator_admin_permissions = true #grant terraform user admin priv
    }

    depends_on = [ aws_iam_role_policy_attachment.eks ]

}