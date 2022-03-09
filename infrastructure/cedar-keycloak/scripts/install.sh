#!/bin/sh

waitForConnection()  {
    echo Waiting for connection...
    echo ContainerId: `hostname`
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

apt-get -y update

apt-get -y install mysql-client
apt-get -y install default-jdk
apt-get -y install ncat
apt-get -y install wget

cd  ${LFC}
mv    keycloak-11.0.2/* /opt/jboss/keycloak

mkdir -p ${CEDAR_KEYCLOAK_HOME}/modules/system/layers/base/com/mysql/jdbc/main
mv mysql-connector-java-5.1.49/mysql-connector-java-5.1.49.jar \
   ${KEYCLOAK_CONFIG_DIR}

rm -rf *
