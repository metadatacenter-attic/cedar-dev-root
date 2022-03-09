#!/bin/sh

waitForConnection() {
    echo waiting...
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

cd ${CEDAR_CA}
mv -f ca.key ca-crt.pem /tmp
rm -rf *
mv -f /tmp/ca.key /tmp/ca-crt.pem .
