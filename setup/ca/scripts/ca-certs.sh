#!/bin/bash

waitForConnection () {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

cd ${CEDAR_CA}

#----------------------------MySQL Certificate--------------------------------

#
# Performed by mysql.metadatacenter.orgx
#
openssl genrsa -out mysql.metadatacenter.orgx.key 2048
openssl req -new -sha256 \
	    -key mysql.metadatacenter.orgx.key \
	    -out mysql.metadatacenter.orgx.csr \
	    -subj "/C=US/ST=CA/L=Stanford/O=BMIR/CN=mysql.metadatacenter.orgx" \
	    -config ${CA_CONFIG_DIR}/openssl-cedar.cnf

#
# Performed by top level CA
#
openssl ca -cert ca-crt.pem -passin pass:${CEDAR_CA_PASSWORD} -keyfile ca.key \
	    -in mysql.metadatacenter.orgx.csr -out mysql.metadatacenter.orgx.crt \
	    -outdir ./ -batch -config ${CA_CONFIG_DIR}/openssl-cedar.cnf
rm mysql.metadatacenter.orgx.csr


#----------------------------NGINX Certificate--------------------------------

#
# Performed by nginx
#
openssl genrsa -out cedar.metadatacenter.orgx.key 2048
openssl req -new -sha256 \
	    -key cedar.metadatacenter.orgx.key \
	    -out cedar.metadatacenter.orgx.csr \
	    -subj "/C=US/ST=CA/L=Stanford/O=BMIR/CN=cedar.metadatacenter.com" \
	    -batch -config ${CA_CONFIG_DIR}/openssl-san.cnf -extensions v3_req

#
# Performed by top level CA
#
openssl ca -cert ca-crt.pem -passin pass:${CEDAR_CA_PASSWORD} -keyfile ca.key \
	    -in cedar.metadatacenter.orgx.csr -out cedar.metadatacenter.orgx.crt \
	    -outdir ./ -batch -config ${CA_CONFIG_DIR}/openssl-san.cnf -extensions v3_req
rm cedar.metadatacenter.orgx.csr

#----------------------------Keycloak Certificate--------------------------------

openssl genrsa -out auth.metadatacenter.orgx.key 2048
openssl req -new -sha256 \
	    -key auth.metadatacenter.orgx.key \
	    -out auth.metadatacenter.orgx.csr \
	    -subj "/C=US/ST=CA/L=Stanford/O=BMIR/CN=auth.metadatacenter.orgx" \
	    -config ${CA_CONFIG_DIR}/openssl-cedar.cnf
#
# Performed by top level CA
#
openssl ca -cert ca-crt.pem -passin pass:${CEDAR_CA_PASSWORD} -keyfile ca.key \
	    -in auth.metadatacenter.orgx.csr -out auth.metadatacenter.orgx.crt \
	    -outdir ./ -batch -config ${CA_CONFIG_DIR}/openssl-cedar.cnf
rm auth.metadatacenter.orgx.csr

# ----------------------------Good for now----------------------------------
