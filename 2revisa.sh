#!/bin/bash
export T=$1
oci iam tenancy get --tenancy-id $OCI_TENANCY > tenancy.json
export REPO=$(cat tenancy.json | jq '.data."home-region-key" | ascii_downcase').ocir.io
export REPODOM=$(cat tenancy.json | jq '.data.name')
export userid=$(grep '"principal_id"' terraform.tfstate  | sort -u | awk -F'"' '{print $4}')
export USU=$(oci iam user get --user-id $userid | jq -r '.data.name')
#export TOKENCLA=$1
if [ a$T == a ]; then
	oci iam auth-token  create --description cloudShell --user-id $userid > token.json
	export TOKENCLA=$(cat token.json | jq -r '.data.token')
else
	TOKENCLA=$T
fi
export KUBECONFIG=$(pwd)/config-kube.txt
export espera=$(pwd)/espera.sh
$espera  nodes
echo "######################################################################"
docker login $REPO -u $REPODOM/$USU -p "$TOKENCLA"
echo "######################################################################"
oci ce node-pool get --profile $DOM --node-pool-id $(cat poolid.txt) > nodos.json
cat nodos.json | jq '.data.nodes[].id' > nodo.txt
