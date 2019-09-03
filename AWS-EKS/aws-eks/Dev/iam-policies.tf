################################################
## AWS IAM Poicies, roles and configuration ####
################################################


################################################
############# EKS Master policies ##############
################################################

resource "aws_iam_role" "eks-dev-cluster" {
  name = "eks-dev-cluster"

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

resource "aws_iam_role_policy_attachment" "eks-dev-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.eks-dev-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "eks-dev-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.eks-dev-cluster.name}"
}

################################################
############# EKS Worker policies ##############
################################################

resource "aws_iam_role" "eks-dev-node" {
  name = "eks-dev-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-dev-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.eks-dev-node.name}"
}

resource "aws_iam_role_policy_attachment" "eks-dev-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.eks-dev-node.name}"
}

resource "aws_iam_role_policy_attachment" "eks-dev-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.eks-dev-node.name}"
}

resource "aws_iam_instance_profile" "eks-dev-node" {
  name = "eks-dev"
  role = "${aws_iam_role.eks-dev-node.name}"
}

