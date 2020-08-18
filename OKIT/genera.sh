#!/bin/bash

git clone https://github.com/oracle/oci-designer-toolkit.git
C=ociconfig/config
P=ociconfig/llave.pem

### Build Docker Image
IMAGENREPO=$REPO/$REPODOM/okit:$v
cd oci-designer-toolkit
docker build --tag okit --tag $IMAGENREPO --file ./containers/docker/Dockerfile .

docker login $REPO -u $REPODOM/$USU -p "$TOKENCLA"
docker push $IMAGENREPO

kubectl create secret generic ocicli --from-file=$C --from-file=$P
helm install okit charts/okit --set imagen=$IMAGENREPO
