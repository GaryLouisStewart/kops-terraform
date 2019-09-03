################################################
################# VPC Setup ####################
################################################

resource "aws_vpc" "eks-dev" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
     "Name", "eks-dev-demo",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}