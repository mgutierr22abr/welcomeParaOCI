#!/bin/bash
export TF_VAR_tenancy_ocid=$OCI_TENANCY
export TF_VAR_region=$OCI_REGION
export TF_VAR_ssh_public_key=$(cat llave.pub)
terraform destroy
