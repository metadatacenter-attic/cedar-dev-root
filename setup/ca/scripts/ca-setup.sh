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
   echo CA already present! Not creating new ca cert.
else
    openssl genrsa -des3 -passout pass:${CEDAR_CA_PASSWORD} -out ca.key 4096
    openssl req -new -x509 -days 3650 \
	        -passin pass:${CEDAR_CA_PASSWORD} -key ca.key  \
		-out ca-crt.pem \
		-subj "/C=US/ST=CA/L=Stanford/O=BMIR/OU=CA/CN=metadatacenter.orgx"
fi
   
#
# The top level CA prepares (gets a self-signed certificate)
#
echo 00 > serial
touch index.txt
touch index.txt.attr
