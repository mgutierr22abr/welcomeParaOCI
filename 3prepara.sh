#!/bin/bash
#kubectl create secret docker-registry ocirsecret --docker-server=$REPO \
	#--namespace=default --docker-username=$REPODOM/$USU \
	#--docker-password=$TOKENCLA --docker-email=$USU
echo "######################################################################"
oci iam dynamic-group create --name "Herramientas" --description "OKE de Herramientas" \
	--matching-rule "ANY {instance.id = $(cat nodo.txt) }"
oci iam policy create --name "Herramientas" --description "OKE de Herramientas" \
  --compartment-id $TF_VAR_tenancy_ocid \
  --statements '[ "Allow dynamic-group Herramientas  to manage all-resources in compartment herramientas",
"define tenancy usage-report as ocid1.tenancy.oc1..aaaaaaaaned4fkpkisbwjlr56u7cj63lf3wffbilvqknstgtvzub7vhqkggq",
"endorse dynamic-group Herramientas to read objects in tenancy usage-report",
"Allow dynamic-group Herramientas to inspect compartments in tenancy",
"Allow dynamic-group Herramientas to inspect tenancies in tenancy",
"Allow dynamic-group Herramientas  to inspect all-resources in tenancy",
"Allow dynamic-group Herramientas  to read instances in tenancy"
  ] '
echo "######################################################################"
cat <<EOF >agenda.txt
CRON_TZ=America/Santiago
00 09 * * * /agenda/opera.sh stop $(cat dbid.txt)
00 18 * * * /agenda/opera.sh stop $(cat dbid.txt)
EOF
