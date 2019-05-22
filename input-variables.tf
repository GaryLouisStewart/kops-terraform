variable "provider" {
  type = "map"
  default = {
    region = "eu-west-1"
    share_creds_file = "~/.aws/credentials"
    aws_profile = "kops_personal"
  }
}
