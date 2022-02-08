#!/bin/bash
echo WARNING... WARNING...  WARNING...
echo There are some password prompts at the end of this script
echo -------------------------------
echo "Creating network (cedarnet)..."
docker network create --subnet=${CEDAR_NET_SUBNET}/24 \
                      --gateway ${CEDAR_NET_GATEWAY} cedarnet
echo "Creating Certificate Volumes"
docker volume create cedar_ca
docker volume create cedar_cert

cd ${CEDAR_SOURCE}/cedar-dev-root/setup
docker-compose up

CERTS=${CEDAR_HOME}/CERTS
mkdir -p ${CERTS}

echo -------------------------------
echo delete any existing certificates

rm ${CEDAR_HOME}/.keystore

rm -f ${CERTS}/*

rm -f ${CEDAR_SOURCE}/cedar-dev-root/infrastructure/cedar-mysql/config/*.pem

#keytool -delete -alias metadatacenter.orgx -noprompt \
#     -keystore ${CEDAR_HOME}/.keystore -storepass ${CEDAR_KEYSTORE_PASSWORD} 
#keytool -delete -alias mysql.metadatacenter.orgx -noprompt \
#     -keystore ${CEDAR_HOME}/.keystore -storepass ${CEDAR_KEYSTORE_PASSWORD} 
#keytool -importcert -alias MySQLCACert -noprompt \
#	-keystore ${CEDAR_HOME}/.keystore -storepass ${CEDAR_KEYSTORE_PASSWORD}


echo --------------------------------
echo Selective copying of certificates made by CA

docker cp ca:/var/ca/ca-crt.pem ${CERTS}
docker cp ca:/var/ca/mysql.metadatacenter.orgx.crt  ${CERTS}

docker cp ca:/var/ca/ca-crt.pem \
       ${CEDAR_SOURCE}/cedar-dev-root/infrastructure/cedar-mysql/config

docker cp ca:/var/ca/mysql.metadatacenter.orgx-crt.pem  \
       ${CEDAR_SOURCE}/cedar-dev-root/infrastructure/cedar-mysql/config
docker cp ca:/var/ca/mysql.metadatacenter.orgx.key  \
       ${CEDAR_SOURCE}/cedar-dev-root/infrastructure/cedar-mysql/config/mysql.metadatacenter.orgx-key.pem

#
# Force a mysql rebuild
#
docker rmi -f cedar-mysql:${CEDAR_DOCKER_VERSION}

echo -------------------------------
echo add new ca certificate
echo -------------------------------
keytool -import -alias metadatacenter.orgx -file ${CERTS}/ca-crt.pem \
	-noprompt \
     -keystore ${CEDAR_HOME}/.keystore -storepass ${CEDAR_KEYSTORE_PASSWORD}
keytool -import -alias mysql.metadatacenter.orgx \
     -file ${CERTS}/mysql.metadatacenter.orgx.crt \
	-noprompt \
     -keystore ${CEDAR_HOME}/.keystore -storepass ${CEDAR_KEYSTORE_PASSWORD}
keytool -importcert -alias MySQLCACert -file ${CEDAR_HOME}/CERTS/ca-crt.pem \
	-noprompt \
	-keystore ${CEDAR_HOME}/.keystore -storepass ${CEDAR_KEYSTORE_PASSWORD}
echo -------------------------------
echo Modifying /etc/hosts
echo -------------------------------
${CEDAR_SOURCE}/cedar-dev-root/bin/util/add-hosts.sh
