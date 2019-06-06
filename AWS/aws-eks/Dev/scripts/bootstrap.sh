#!/bin/bash
# bootstrap final settings on Amazon EKS Setup

terraform output kubeconfig > ./kubeconfig
terraform output config_map_aws_auth > ./configmapawsauth.yaml
kubectl apply -f config_map_aws_auth.yaml
