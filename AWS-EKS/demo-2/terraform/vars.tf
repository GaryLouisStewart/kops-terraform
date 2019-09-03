variable "provider" {
  default = {
    region = "eu-west-1"
    shared_creds_file = "~/.aws/credentials"
    aws_profile = "gary"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "instance_type" {
  default = "t2.micro"
}