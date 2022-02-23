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

keytool -import -alias metadatacenter.orgx -file ca-crt.pem \
	-noprompt \
     -keystore java-keystore -storepass pass:${CEDAR_CA_PASSWORD}
keytool -import -alias mysql.metadatacenter.orgx \
     -file mysql.metadatacenter.orgx.crt \
	-noprompt \
     -keystore java-keystore -storepass pass:${CEDAR_CA_PASSWORD}
keytool -importcert -alias MySQLCACert -file ca-crt.pem \
	-noprompt \
	-keystore java-keystore -storepass pass:${CEDAR_CA_PASSWORD}

#
# Make the keycloak keystore which can be created by keycloak because it has its
# private key and the ${CEDAR_KEYCLOAK_KEYSTORE_PASSWORD}
#

echo creating pkcs12 keystore
openssl pkcs12 -export -in auth.metadatacenter.orgx.crt \
                       -inkey auth.metadatacenter.orgx.key \
		       -out auth.metadatacenter.orgx.pkcs12 \
		       -password pass:${CEDAR_KEYCLOAK_KEYSTORE_PASSWORD} \
		       -name auth.metadatacenter.orgx


echo importing pkcs12 keystore into java keystore
keytool -importkeystore  \
	-srckeystore auth.metadatacenter.orgx.pkcs12 \
	-srcstorepass ${CEDAR_KEYCLOAK_KEYSTORE_PASSWORD} \
	-destkeystore keycloak-keystore \
	-deststorepass ${CEDAR_KEYCLOAK_KEYSTORE_PASSWORD} \
	-alias auth.metadatacenter.orgx

echo Copying CA files
cp ca-crt.pem mysql.metadatacenter.orgx-crt.pem ${MYSQL_CERTS}
cp mysql.metadatacenter.orgx.key \
   ${MYSQL_CERTS}/mysql.metadatacenter.orgx-key.pem

cp ca-crt.pem *.metadatacenter.orgx.* ${NGINX_CERTS}
rm ${NGINX_CERTS}/mysql.metadatacenter.orgx.key 

cp keycloak-keystore ${KEYCLOAK_CERTS}
