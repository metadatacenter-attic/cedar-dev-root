#!/bin/bash

echo "Clearing the decks..."
docker rm -f `docker ps -a -q`
docker rmi -f `docker images -a -q`
docker volume rm `docker volume ls -q`
docker network rm `docker network ls -q`
echo "Creating network (cedarnet)..."
docker network create --subnet=${CEDAR_NET_SUBNET}/24 \
                      --gateway ${CEDAR_NET_GATEWAY} cedarnet
echo "Creating Certificate Volumes"
docker volume create cedar_ca
docker volume create cedar_cert

echo "Creating source volume"
docker volume create --driver local \
       -o o=bind -o type=none -o device=${CEDAR_HOME}/mounts/src \
       cedar_source

cd ${CEDAR_HOME}/cedar-dev-root/setup
docker-compose up
