#!/bin/bash
### Build Docker Image
IMAGENREPO=$REPO/$REPODOM/agenda

docker build --tag agenda --tag $IMAGENREPO --file ./Dockerfile --force-rm .

if [ $? -ne 0 ]; then
	exit
fi
docker login $REPO -u $REPODOM/$USU -p "$TOKENCLA"
docker push $IMAGENREPO

kubectl create secret generic agenda --from-file=../agenda.txt
helm install agenda charts/agenda --set imagen=$IMAGENREPO
../espera.sh pod agenda
