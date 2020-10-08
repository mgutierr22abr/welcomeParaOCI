#!/bin/bash
export MITOKEN=$1
./1terraform.sh
. ./2revisa.sh $MITOKEN
./3prepara.sh
cd OKIT
./genera.sh
cd ..
cd UsageReports
./genera.sh
cd ..
cd Agenda
./genera.sh
cd ..
