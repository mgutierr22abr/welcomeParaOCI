#!/bin/bash
export T=$1
#oci iam tenancy get --tenancy-id $OCI_TENANCY > tenancy.json
oci iam compartment get --compartment-id $OCI_TENANCY > comproot.json
oci iam region list > reg.json
P=$(cat reg.json | jq -r '.data[] | select( .name == "'$OCI_REGION'" ) | .key | ascii_downcase')
export REPO=$P.ocir.io
export REPODOM=$(oci os ns get | jq -r '.data')
export userid=$(grep '"principal_id"' terraform.tfstate  | sort -u | awk -F'"' '{print $4}')
export USU=$(oci iam user get --user-id $userid | jq -r '.data.name')
if [ a$T == a ]; then
	oci iam auth-token  create --description cloudShell --user-id $userid > token.json
	export TOKENCLA=$(cat token.json | jq -r '.data.token')
else
	export TOKENCLA=$T
fi
export KUBECONFIG=$(pwd)/config-kube.txt
export espera=$(pwd)/espera.sh
$espera  nodes
echo "######################################################################"
docker login $REPO -u $REPODOM/$USU -p "$TOKENCLA"
echo "######################################################################"
oci ce node-pool get --node-pool-id $(cat poolid.txt) > nodos.json
cat nodos.json | jq -r '.data.nodes[]."public-ip"' > ipnodo.txt
cat nodos.json | jq '.data.nodes[].id' > nodo.txt
