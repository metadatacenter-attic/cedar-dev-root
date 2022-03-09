#!/bin/bash

waitForConnection () {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

makeCertificate() {
    server=$1
    config=$2
    cd ${CEDAR_CA}
    #
    # Performed by nginx
    #
    openssl genrsa -out ${server}.metadatacenter.orgx.key 2048
    openssl req -new -sha256 \
	    -key ${server}.metadatacenter.orgx.key \
	    -out ${server}.metadatacenter.orgx.csr \
	    -subj "/C=US/ST=CA/L=Stanford/O=BMIR/CN=${server}.metadatacenter.orgxr" \
	    -batch -config ${config}

    #
    # Performed by top level CA
    #
    openssl ca -cert ca-crt.pem -passin pass:${CEDAR_CA_PASSWORD} -keyfile ca.key \
	    -in ${server}.metadatacenter.orgx.csr -out ${server}.metadatacenter.orgx.crt \
	    -outdir ./ -batch -config ${config}
    rm ${server}.metadatacenter.orgx.csr
}

cd ${CEDAR_CA}


#----------------------------NGINX Certificate--------------------------------
#                       The NGINX certificate is special only because
#                       it is a san certificate and needs a special
#                       configuration file

makeCertificate nginx  "${CA_CONFIG_DIR}/openssl-san.cnf -extensions v3_req" 

#----------------------------MySQL Certificate--------------------------------

makeCertificate mysql ${CA_CONFIG_DIR}/openssl-cedar.cnf

#----------------------------Keycloak Certificate--------------------------------

makeCertificate keycloak ${CA_CONFIG_DIR}/openssl-cedar.cnf

#----------------------------Neo4j Certificate--------------------------------

makeCertificate neo4j ${CA_CONFIG_DIR}/openssl-cedar.cnf

# ----------------------------Good for now----------------------------------
