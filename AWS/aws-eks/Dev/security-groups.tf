################################################
### Security group & security related config ###
################################################

################################################
########## EKS Master Security config ##########
################################################

resource "aws_security_group" "eks-dev-cluster" {
  name        = "eks-dev-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.eks-dev.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-dev"
  }
}

##############################################
# Allows access in from workstation securely #
##############################################

resource "aws_security_group_rule" "eks-dev-cluster-ingress-workstation-https-secure" {
  count             = "${var.cidr_block_ingress_workstation_secure != "" ? 1 : 0}"
  cidr_blocks       = ["${var.cidr_ingress_workstation}"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.eks-dev-cluster.id}"
  to_port           = 443
  type              = "ingress"
}

#################################################
# Allows access in from workstation insecurely ##
#################################################

resource "aws_security_group_rule" "eks-dev-cluster-ingress-workstation-https-insecure" {
  count             = "${var.cidr_block_ingress_workstation_insecure != "" ? 1 : 0}"
  cidr_blocks       = ["${chomp(data.http.myipaddr.body)}/32"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.eks-dev-cluster.id}"
  to_port           = 443
  type              = "ingress"
}

################################################
########## EKS Worker Security config ##########
################################################

resource "aws_security_group" "eks-dev-node" {
  name        = "eks-dev-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${aws_vpc.eks-dev.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "eks-dev-node",
     "kubernetes.io/cluster/${var.cluster-name}", "owned",
    )
  }"
}

resource "aws_security_group_rule" "eks-dev-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.eks-dev-node.id}"
  source_security_group_id = "${aws_security_group.eks-dev-node.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-dev-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.eks-dev-node.id}"
  source_security_group_id = "${aws_security_group.eks-dev-node.id}"
  to_port                  = 65535
  type                     = "ingress"
}

################################################
########## EKS Worker => Master Access #########
################################################

resource "aws_security_group_rule" "eks-dev-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.eks-dev-cluster.id}"
  source_security_group_id = "${aws_security_group.eks-dev-node.id}"
  to_port                  = 443
  type                     = "ingress"
}