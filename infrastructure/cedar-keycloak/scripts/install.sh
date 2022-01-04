#!/bin/sh

microdnf -y install java-11-openjdk-headless
alternatives --set java java-11-openjdk.x86_64

microdnf -y install dnf
dnf -y install ${KEYCLOAK_CONFIG_DIR}/mysql80-community-release-el8-2.noarch.rpm
dnf -y install mysql

#mkdir --parents /sleep
while [ -e /sleep ]
do
    sleep 10
done
