#!/bin/bash

export KEYCLOAK_IMPORT=/opt/jboss/realm-import/keycloak-realm.CEDAR.development.20201020.json

export DB_NAME=MySQL
export DB_ADDR=${CEDAR_KEYCLOAK_MYSQL_HOST}
export DB_PORT=${CEDAR_KEYCLOAK_MYSQL_PORT}
export DB_DATABASE=${CEDAR_KEYCLOAK_MYSQL_DB}
export DB_USER=${CEDAR_KEYCLOAK_MYSQL_USER}
export DB_PASSWORD=${CEDAR_KEYCLOAK_MYSQL_PASSWORD}

export JDBC_PARAMS="useSSL=false"

#
# the operative part is the wait but I need a command
#
mysqladmin --wait --host ${DB_ADDR} --user ${DB_USER} \
	   --password=${DB_PASSWORD} ping

/opt/jboss/tools/docker-entrypoint.sh

mkdir --parents /sleep
while [ -e /sleep ]
do
    sleep 5
done
