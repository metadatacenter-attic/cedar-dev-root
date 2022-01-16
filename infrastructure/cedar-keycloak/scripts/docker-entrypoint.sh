#!/bin/bash

waitForConnection() {
    mkdir --parents /sleep
    while [ -e /sleep ]
    do
	sleep 5
    done
}


export KEYCLOAK_IMPORT=/opt/jboss/realm-import/keycloak-realm.CEDAR.development.20201020.json

export DB_NAME=MySQL
export DB_ADDR=${CEDAR_KEYCLOAK_MYSQL_HOST}
export DB_PORT=${CEDAR_KEYCLOAK_MYSQL_PORT}
export DB_DATABASE=${CEDAR_KEYCLOAK_MYSQL_DB}
export DB_USER=${CEDAR_KEYCLOAK_MYSQL_USER}
export DB_PASSWORD=${CEDAR_KEYCLOAK_MYSQL_PASSWORD}

export JDBC_PARAMS="useSSL=false"

#
# This is bad...
#
sleep 30
#
# I tried to fix it with
#    mysqladmin --wait --host ${DB_ADDR} --user ${DB_USER} \
#	   --password=${DB_PASSWORD} ping
# but failed with the error "Lost connection to MySQL server at
# 'reading initial communication packet', system error: 0".  I think
# that this happens when mysql is up for a short time to initialize
# the users.  If I roll my own mysql with my own volumes, I think that
# I can prevent this.
#
# The operative part is the wait but I need a command
#

echo Waiting for mysql to come up with the command:
echo mysqladmin --wait --host ${DB_ADDR} --user ${DB_USER} \
	   --password=${DB_PASSWORD} ping

mysqladmin --wait --host ${DB_ADDR} --user ${DB_USER} \
	   --password=${DB_PASSWORD} ping

/opt/jboss/tools/docker-entrypoint.sh
