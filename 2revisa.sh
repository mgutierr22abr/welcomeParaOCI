#!/bin/bash
#export TOKENCLA=$1
oci iam tenancy get --tenancy-id $OCI_TENANCY > tenancy.json
export REPO=$(cat tenancy.json | jq '.data."home-region-key" | ascii_downcase').ocir.io
export REPODOM=$(cat tenancy.json | jq '.data.name')
#export USU=
export KUBECONFIG=$(pwd)/config-kube.txt
export espera=$(pwd)/espera.sh
$espera nodes
echo "######################################################################"
docker login $REPO -u $REPODOM/$USU -p "$TOKENCLA"
echo "######################################################################"
oci ce node-pool get --profile $DOM --node-pool-id $(cat poolid.txt) > nodos.json
cat nodos.json | jq '.data.nodes[].id' > nodo.txt
