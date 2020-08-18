#!/bin/bash
que=$1
cual=$2
if [ $que == pod ]; then
	n=0
	while [ $n -eq 0 ]; do
		echo "Esperando pod Running $cual ..."
		sleep 15
		kubectl get pods --all-namespaces | grep $cual | tee /tmp/pods.txt
		n=$(cat /tmp/pods.txt | grep $cual | grep Running | wc -l)
	done
else if [ $que == podc ]; then
	n=0
	while [ $n -eq 0 ]; do
		echo "Esperando pod Completed $cual ..."
		sleep 15
		kubectl get pods --all-namespaces | grep $cual | tee /tmp/pods.txt
		n=$(cat /tmp/pods.txt | grep $cual | grep Complete | wc -l)
	done
else if [ $que == nodes ]; then
	n=0
	while [ $n -ne 1 ]; do
		echo "Esperando nodos ..."
        	sleep 15
		kubectl get nodes | tee /tmp/nodes.txt
		n=$(cat /tmp/nodes.txt | grep Ready | grep -v NotReady | wc -l)
	done
else if [ $que == svc ]; then
	n=0
	while [ $n -eq 0 ]; do
		echo "Esperando LoadBalancer $cual ...."
		sleep 10
		kubectl get svc --all-namespaces | grep $cual | tee /tmp/svc.txt
		n=$(cat /tmp/svc.txt | grep $cual | grep LoadBalancer | grep -v -i pending | wc -l)
	done
fi
fi
fi
fi
