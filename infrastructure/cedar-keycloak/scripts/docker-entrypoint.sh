#!/bin/bash

waitForConnection() {
    echo Waiting for connection...
    echo ContainerId: keycloak
    mkdir --parents /sleep
    while [ -e /sleep ]
    do
	sleep 5
    done
}

${KEYCLOAK_SCRIPTS_DIR}/configure-volumes.sh

export DB_NAME=MySQL
export DB_ADDR=${CEDAR_KEYCLOAK_MYSQL_HOST}
export DB_PORT=${CEDAR_KEYCLOAK_MYSQL_PORT}
export DB_DATABASE=${CEDAR_KEYCLOAK_MYSQL_DB}
export DB_USER=${CEDAR_KEYCLOAK_MYSQL_USER}
export DB_PASSWORD=${CEDAR_KEYCLOAK_MYSQL_PASSWORD}

export JDBC_PARAMS="useSSL=false"

#
# I tried to fix it with
#    mysqladmin --wait --host ${DB_ADDR} --user ${DB_USER} \
#	   --password=${DB_PASSWORD} ping
# but failed with the error "Lost connection to MySQL server at
# 'reading initial communication packet', system error: 0".  I think
# that this happens when mysql is up for a short time to initialize
# the users.  
# The operative part is the wait but I need a command
#

while ! nc -w 3 -z ${CEDAR_KEYCLOAK_MYSQL_HOST} ${CEDAR_KEYCLOAK_MYSQL_PORT}
do
    sleep 1
done

echo MySQL is almost ready

echo Waiting for mysql to come up with the command:
echo mysqladmin --wait --host ${DB_ADDR} --user ${DB_USER} \
	   --password=${DB_PASSWORD} ping

mysqladmin --wait  --host ${DB_ADDR} --user ${DB_USER} \
	   --password=${DB_PASSWORD} ping \
	   > /tmp/mysql-status 2>&1
while ! grep -i alive /tmp/mysql-status
do
    sleep 5
    echo not quite
    mysqladmin --wait  --host ${DB_ADDR} --user ${DB_USER} \
	   --password=${DB_PASSWORD} ping \
	   > /tmp/mysql-status 2>&1
done
cat /tmp/mysql-status

echo if alive MySQL is ready


if [ -e /tmp/firstRun ]
then
    rm /tmp/firstRun
    /opt/jboss/keycloak/bin/standalone.sh \
	-Dkeycloak.migration.action=import \
	-Dkeycloak.migration.provider=singleFile \
	-Dkeycloak.migration.file=${KEYCLOAK_CONFIG_DIR}/keycloak-realm.CEDAR.development.20201020.json \
	-Dkeycloak.migration.strategy=IGNORE_EXISTING
else
    /opt/jboss/keycloak/bin/standalone.sh
fi

