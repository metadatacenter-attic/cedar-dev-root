#!/bin/bash

waitForConnection() {
    echo Waiting for connection...
    echo ContainerId: `hostname`
    mkdir --parents /sleep
    while [ -e /sleep ]
    do
	sleep 5
    done
}

apt-get update

apt-get upgrade -y

apt-get install -y tzdata <<EOF
US
Pacific
EOF

apt-get install -y wget gnupg

wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc |  apt-key add -


echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" |  tee /etc/apt/sources.list.d/mongodb-org-4.4.list

apt-get update
apt-get install -y mongodb-org

mkdir --parents ${MONGO_DB_PATH}
mkdir --parents ${MONGO_LOG_PATH}

