#!/bin/sh

waitForConnection() {
    echo Waiting for connection...
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 3
    done
}

${CA_SCRIPTS_DIR}/ca-setup.sh
${CA_SCRIPTS_DIR}/ca-certs.sh
${CA_SCRIPTS_DIR}/ca-misc.sh

#waitForConnection
