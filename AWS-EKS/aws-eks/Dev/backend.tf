################################################
######## terraform backend configuration #######
# this will change depending on name, location #
##### & aws profile that you are using #########
################################################

terraform {
  backend "s3" {
    bucket = "eks-clusters"
    key    = "eks/eks-dev/terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region                  = "${var.provider["region"]}"
  shared_credentials_file = "${var.provider["shared_creds_file"]}"
  profile                 = "${var.provider["aws_profile"]}"
}
