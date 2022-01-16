#!/bin/bash

waitForConnection() {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 3
    done
}

apt-get -y update
apt-get -y upgrade
apt-get -y install openssl
