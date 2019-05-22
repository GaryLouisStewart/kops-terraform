terraform {
  backend "s3" {
    bucket = "kops-gls-2019.demo.com"
    key    = "terraform/kops-demo/tf.state"
    region = "eu-west-1"
  }
}

