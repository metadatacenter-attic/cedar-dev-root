#!/bin/bash

waitForConnection() {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

chown ${USER} ${CEDAR_SOURCE}

runuser -u ${USER} ${SCRIPT_DIR}/checkout-sources.sh
