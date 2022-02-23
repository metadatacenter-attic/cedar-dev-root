#!/bin/sh

waitForConnection() { 
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 15
    done
}
#
# The configure script is here instead of loaded from the Dockerfile
# because there is an anonymous volume created by the parent image.
# Try "docker volume ls" after mysql is up. There is no way (that I
# can see) to ensure that this volume is present during the
# initialization of the image.
#
${MYSQL_SCRIPTS_DIR}/configure-volumes.sh

#waitForConnection

echo Real run of mysqld starting
mysqld --user=mysql --datadir=${MYSQL_DATA_DIR} --ssl  
