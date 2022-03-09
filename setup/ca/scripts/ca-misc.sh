#!/bin/bash

waitForConnection () {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

cd ${CEDAR_CA}

#
# File format changes - anybody can do this
#
openssl x509 -in mysql.metadatacenter.orgx.crt -out mysql.metadatacenter.orgx-crt.pem

#
# make java keystores which can be done by anyone who has the
# #{CEDAR_KEYSTORE_PASSWORD}.
#

keytool -import -alias mysql.metadatacenter.orgx \
     -file mysql.metadatacenter.orgx.crt \
	-noprompt \
     -keystore java-keystore -storepass ${CEDAR_KEYSTORE_PASSWORD}
keytool -importcert -alias MySQLCACert -file ca-crt.pem \
	-noprompt \
	-keystore java-keystore -storepass ${CEDAR_KEYSTORE_PASSWORD}
keytool -import -alias metadatacenter.orgx -file ca-crt.pem \
	-noprompt -trustcacerts \
     -keystore java-keystore -storepass ${CEDAR_KEYSTORE_PASSWORD}

#
# Make the keycloak keystore which can be created by keycloak because it has its
# private key and the ${CEDAR_KEYCLOAK_KEYSTORE_PASSWORD}
#

echo creating pkcs12 keystore
openssl pkcs12 -export -in keycloak.metadatacenter.orgx.crt \
                       -inkey keycloak.metadatacenter.orgx.key \
		       -out keycloak.metadatacenter.orgx.pkcs12 \
		       -password pass:${CEDAR_KEYCLOAK_KEYSTORE_PASSWORD} \
		       -name keycloak.metadatacenter.orgx


echo importing pkcs12 keystore into java keystore
keytool -importkeystore  \
	-srckeystore keycloak.metadatacenter.orgx.pkcs12 \
	-srcstorepass ${CEDAR_KEYCLOAK_KEYSTORE_PASSWORD} \
	-destkeystore keycloak-keystore \
	-deststorepass ${CEDAR_KEYCLOAK_KEYSTORE_PASSWORD} \
	-alias keycloak.metadatacenter.orgx

echo Copying CA files
cp ca-crt.pem mysql.metadatacenter.orgx-crt.pem ${MYSQL_CERTS}
cp mysql.metadatacenter.orgx.key \
   ${MYSQL_CERTS}/mysql.metadatacenter.orgx-key.pem

cp ca-crt.pem *.metadatacenter.orgx.* ${NGINX_CERTS}
rm ${NGINX_CERTS}/mysql.metadatacenter.orgx.key \
   ${NGINX_CERTS}/neo4j.metadatacenter.orgx.key \
   ${NGINX_CERTS}/keycloak.metadatacenter.orgx.key

cp keycloak-keystore ${KEYCLOAK_CERTS}
cp keycloak.metadatacenter.orgx.key ${KEYCLOAK_CERTS}
cp keycloak.metadatacenter.orgx.crt ${KEYCLOAK_CERTS}


cp neo4j.metadatacenter.orgx.key neo4j.metadatacenter.orgx.crt ${NEO4J_CERTS}
