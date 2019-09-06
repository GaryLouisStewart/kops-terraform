#!/bin/bash
# bootstrap tiller to use proper service account and delegate correct rbac permissions

kubectl create -f tiller-rbac.yaml
helm init --service-account tiller --history-max 200 
