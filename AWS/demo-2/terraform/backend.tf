terraform {
  backend "s3" {
    bucket = "kops-gls-2019.demo.com"
    key    = "terraform/aws-demo2/terraform.tfstate"
    region = "eu-west-1"
  }
}