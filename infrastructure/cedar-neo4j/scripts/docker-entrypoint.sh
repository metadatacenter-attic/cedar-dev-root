#!/bin/sh

waitForConnection() {
    echo waiting...
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

${NEO4J_SCRIPTS_DIR}/configure-volumes.sh

/docker-entrypoint.sh neo4j
