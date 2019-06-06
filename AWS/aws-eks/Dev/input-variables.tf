variable "cluster-name" {
   description = "The Name of our EKS cluster"
   type = "string"
   default = "eks-dev"
}

variable "provider" {
  description = "Configuration for the aws provider including: profile, region and credentials file location"
  type = "map"
  default = {
    region = "eu-west-2"
    shared_creds_file = "~/.aws/credentials"
    aws_profile = "gary"
  }
}

variable "cidr_block_ingress_workstation_secure" {
  description = "If variable is set, this variable will allow an insecure rule to be manually defined using the 'cidr_ingress_workstation' variable"
  type = "string"
  default = ""
}

variable "cidr_block_ingress_workstation_insecure" {
  description = "If set to true will create a secure rule to allow https traffic to kuberenetes master from IP specified, this will default to your public ip"
  type = "string"
  default = "true"
}

variable "cidr_ingress_workstation" {
  description = "Allows access in from a cidr block, defaults to 0.0.0.0/0"
  type = "string"
  default = "0.0.0.0/0"
}