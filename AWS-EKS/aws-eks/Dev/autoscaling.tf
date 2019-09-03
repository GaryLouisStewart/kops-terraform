################################################
# Autoscaling, AMI & launch config worker nodes #
################################################

data "aws_ami" "eks-dev-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.eks-dev.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

resource "aws_launch_configuration" "eks-dev-node" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.eks-dev-node.name}"
  image_id                    = "${data.aws_ami.eks-dev-worker.id}"
  instance_type               = "m4.large"
  name_prefix                 = "terraform-eks-demo"
  security_groups             = ["${aws_security_group.eks-dev-node.id}"]
  user_data_base64            = "${base64encode(local.eks-dev-node-userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "eks-dev" {
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.eks-dev-node.id}"
  max_size             = 2
  min_size             = 1
  name                 = "terraform-eks-dev"
  vpc_zone_identifier  = ["${aws_subnet.eks-dev.*.id}"]

  tag {
    key                 = "Name"
    value               = "eks-dev"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster-name}"
    value               = "owned"
    propagate_at_launch = true
  }
}