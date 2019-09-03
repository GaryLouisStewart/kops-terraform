################################################
############# EKS Master Cluster ###############
################################################

resource "aws_eks_cluster" "eks-dev" {
  name            = "${var.cluster-name}"
  role_arn        = "${aws_iam_role.eks-dev-cluster.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.eks-dev-cluster.id}"]
    subnet_ids         = ["${aws_subnet.eks-dev.*.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.eks-dev-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.eks-dev-cluster-AmazonEKSServicePolicy",
  ]
}