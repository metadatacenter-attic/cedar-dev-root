#!/bin/bash

waitForConnection () {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

cd ${CEDAR_CA}

if [ -e ca-crt.pem ]
then
   echo CA already present! Exiting...
   exit 0
fi
   
#
# The top level CA prepares (gets a self-signed certificate)
#
openssl genrsa -des3 -passout pass:${CEDAR_CA_PASSWORD} -out ca.key 4096
openssl req -new -x509 -days 3650 \
  -passin pass:${CEDAR_CA_PASSWORD} -key ca.key  \
  -out ca-crt.pem \
  -subj "/C=US/ST=CA/L=Stanford/O=BMIR/OU=CA/CN=metadatacenter.orgx"
echo 00 > serial
touch index.txt
touch index.txt.attr

for server in mysql \
	      cedar artifact auth component group impex internals \
		    messaging open openview repo resource schema \
		    submission terminology user valuerecommender worker
do
    #
    # Performed by ${server}.metadatacenter.orgx
    #
    openssl genrsa -out ${server}.metadatacenter.orgx.key 2048
    openssl req -new -sha256 \
	    -key ${server}.metadatacenter.orgx.key \
	    -out ${server}.metadatacenter.orgx.csr \
	    -subj "/C=US/ST=CA/L=Stanford/O=BMIR/CN=${server}.metadatacenter.orgx"
    #
    # Performed by top level CA
    #

    openssl ca -cert ca-crt.pem -passin pass:${CEDAR_CA_PASSWORD} -keyfile ca.key \
	    -in ${server}.metadatacenter.orgx.csr -out ${server}.metadatacenter.orgx.crt \
	    -outdir ./ -batch -extensions v3_req -config ${CA_CONFIG_DIR}/openssl-san.cnf
done
#
# File format changes - anybody can do this
#
openssl x509 -in mysql.metadatacenter.orgx.crt -out mysql.metadatacenter.orgx-crt.pem
