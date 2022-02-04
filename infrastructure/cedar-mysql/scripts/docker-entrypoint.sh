#!/bin/sh

waitForConnection() { 
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 15
    done
}

${MYSQL_SCRIPTS_DIR}/configure.sh

#waitForConnection

mysqld --user=mysql --datadir=${MYSQL_DATA_DIR} --ssl  
