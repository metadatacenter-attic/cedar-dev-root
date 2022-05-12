#!/bin/bash

waitForConnection() {
    mkdir /sleep
    echo `hostname`
    while [ -e /sleep ]
    do
	sleep 3
    done
}

export DEBIAN_FRONTEND=noninteractive

apt-get -y update
apt-get -y upgrade
apt-get -y install openssl
apt-get -y install openjdk-11-jre-headless
