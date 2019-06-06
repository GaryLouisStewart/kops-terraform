################################################
## Networking within our eks environment VPC ##
################################################

###################################
############## subnets ############
###################################

data "aws_availability_zones" "available" {}

resource "aws_subnet" "eks-dev" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.eks-dev.id}"

  tags = "${
    map(
     "Name", "eks-dev",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

###################################
######### Internet gateway ########
###################################

resource "aws_internet_gateway" "eks-dev" {
  vpc_id = "${aws_vpc.eks-dev.id}"

  tags = {
    Name = "eks-dev"
  }
}

###################################
# Routing tables & associations ###
###################################

resource "aws_route_table" "eks-dev" {
  vpc_id = "${aws_vpc.eks-dev.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.eks-dev.id}"
  }
}

resource "aws_route_table_association" "eks-dev" {
  count = 2

  subnet_id      = "${aws_subnet.eks-dev.*.id[count.index]}"
  route_table_id = "${aws_route_table.eks-dev.id}"
}