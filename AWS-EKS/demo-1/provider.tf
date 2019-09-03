provider "aws" {
  region                  = "${var.provider["region"]}"
  shared_credentials_file = "${var.provider["shared_creds_file"]}"
  profile                 = "${var.provider["aws_profile"]}"
}
