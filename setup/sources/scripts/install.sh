#!/bin/bash

waitForConnection() {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

apt-get update -y
apt-get install -y git

groupadd --gid ${MY_GID} Development
useradd  --uid ${MY_UID} --gid ${MY_GID} ${USER}
