#!/bin/bash

git clone https://github.com/oracle/oci-designer-toolkit.git
C=ociconfig/config
P=ociconfig/llave.pem

### Build Docker Image
IMAGENREPO=$REPO/$REPODOM/okit:$v
cd oci-designer-toolkit
docker build --tag okit --tag $IMAGENREPO --file ./containers/docker/Dockerfile .

docker push $IMAGENREPO

cd ..
kubectl create secret generic ocicli --from-file=$C --from-file=$P
helm install okit charts/okit --set imagen=$IMAGENREPO
$espera pod okit
echo "revisar en http://$(cat ../ipnodo.txt):30300/designer/okit"
