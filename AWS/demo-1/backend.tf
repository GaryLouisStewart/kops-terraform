terraform {
  backend "s3" {
    bucket = "kops-gls-2019.demo.com"
    key    = "terraform/aws-demo1/tf.state"
    region = "eu-west-1"
  }
}

