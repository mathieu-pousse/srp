#!/bin/bash

unset DOCKER_HOST

docker rm -f swarm-manager swarm-node || true

SWARM_ID="b8d8d7d055def5ebaa4c5a2809d7f3e6"
#SWARM_ID=$(docker run --rm swarm create)

echo "Swarm id is ${SWARM_ID}"

MYIP=$(ifconfig ${1:-eth0} | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
if [ "${MYIP}" == "" ]; then
	echo "Unable to find my ip"
	exit 2
fi

echo "Running with ip ${MYIP}"

docker run -d --name swarm-node swarm join --addr=${MYIP}:2375 token://${SWARM_ID}
docker run -d --name swarm-manager -p 5000:2375 swarm manage token://${SWARM_ID}

export DOCKER_HOST=${MYIP}:5000

sleep 5
docker info
