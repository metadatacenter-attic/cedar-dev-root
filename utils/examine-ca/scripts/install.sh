#!/bin/bash

waitForConnection() {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 3
    done
}

export DEBIAN_FRONTEND=noninteractive

ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

apt-get -y update
apt-get -y upgrade
apt-get -y install openssl
apt-get -y install openjdk-11-jre-headless
dpkg-reconfigure --frontend noninteractive tzdata
