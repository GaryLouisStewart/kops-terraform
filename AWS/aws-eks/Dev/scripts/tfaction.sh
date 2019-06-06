#!/bin/bash
# This script will allow us to run terraform actions and outputs logging into
## the logs folder with each of the logs labelled to their respective actio

set DATE=`date '+%Y-%m-%d %H:%M:%S'`

function tfplan {
	terraform plan -out=./logs/terraform-plan-log-$DATE
}

function tfapply {
	terraform apply --var-file=../terraform.tfvars -out=./logs/terraform-apply-log-$DATE
}

function tfdestroy {
	terraform plan -destroy --var-file=../terraform.tfvars -out=./logs/terraform-destroy-log-$DATE
}

function tfoutput {
    if [ "$#" -lt 2 ]; then
		echo "Usage: ./tf-action.sh tfoutput <resource-name>"
		exit 1
	else
		terraform output "$#"
	fi
}

case "$1" in
	plan)
		tfplan
		;;
	apply)
		tfapply
		;;
	destroy)
		tfdestroy
		;;
	output)
        tfoutput
        ;;
esac