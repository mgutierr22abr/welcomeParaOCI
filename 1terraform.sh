#!/bin/bash
export TF_VAR_tenancy_ocid=$OCI_TENANCY
export TF_VAR_region=$OCI_REGION
ssh-keygen -f llave -N ""
export TF_VAR_ssh_public_key=$(cat llave.pub)
terraform init
terraform plan
terraform apply
