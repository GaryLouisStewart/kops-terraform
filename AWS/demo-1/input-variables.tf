variable "provider" {
  type = "map"
  default = {
    region = "eu-west-1"
    shared_creds_file = "~/.aws/credentials"
    aws_profile = "gary"
  }
}

variable "AMIS" {
  type = "map"
  default = {
    eu-west-1 = "ami-ee0b0688"
  }
}