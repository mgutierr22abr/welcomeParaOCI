#!/bin/bash
### Build Docker Image
IMAGENREPO=$REPO/$REPODOM/usage
NOMBRE=usage
PW="Welcome#1#1#1"

git clone https://github.com/oracle/oci-python-sdk
mv oci-python-sdk/examples/usage_reports_to_adw UsageReports

docker build --tag usage --tag $IMAGENREPO .

if [ $? -ne 0 ]; then
	exit
fi
docker login $REPO -u $REPODOM/$USU -p "$TOKENCLA"
docker push $IMAGENREPO

mkdir -p wallet
cd wallet
unzip ../wallet.zip
sed -i '1,$s#?/network/admin#/app/config#g' sqlnet.ora
cd ..

kubectl create secret generic adbusage \
      --from-literal=pw="$PW" \
      --from-literal=nombre="${NOMBRE}" \
      --from-file=./wallet 

helm install usage charts/usage --set imagen=$IMAGENREPO
../espera.sh pod usage
echo "usuario: usage2/$PW  $(cat apexurl.txt)"
