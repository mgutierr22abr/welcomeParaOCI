#!/bin/bash
export TZ=America/Santiago
accion=$1
id=$2
echo "Fecha $(date) Accion $accion ID: $id" > /agenda/last.log
echo "Fecha $(date) Accion $accion ID: $id" >> /agenda/agenda.log
if [ $(echo $id | grep instance | wc -l) -ne 0 ]; then
	oci compute instance action  --instance-id $id --action $accion --auth instance_principal >> /agenda/last.log
else if [ $(echo $id | grep autonomous | wc -l) -ne 0 ]; then
	oci db  autonomous-database $accion --autonomous-database-id $id --auth instance_principal >> /agenda/last.log
else if [ $(echo $id | grep dbnode | wc -l) -ne 0 ]; then
	oci db node $accion --db-node-id $id --auth instance_principal >> /agenda/last.log
fi
fi
fi
