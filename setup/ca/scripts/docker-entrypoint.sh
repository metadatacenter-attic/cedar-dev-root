#!/bin/sh

waitForConnection() {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 3
    done
}

${CA_SCRIPTS_DIR}/ca.sh
${CA_SCRIPTS_DIR}/copyFiles.sh

#waitForConnection
