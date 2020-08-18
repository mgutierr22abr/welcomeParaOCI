#!/bin/bash
export TF_VAR_tenancy_ocid=$OCI_TENANCY
terraform init
terraform plan
terraform apply
