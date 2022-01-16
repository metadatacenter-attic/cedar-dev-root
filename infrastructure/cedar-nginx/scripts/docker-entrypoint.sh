#!/bin/sh

cp ${CEDAR_CERTS_VOL}/cedar.metadatacenter.orgx.crt ${CEDAR_SSL_DIR}
cp ${CEDAR_CERTS_VOL}/cedar.metadatacenter.orgx.key ${CEDAR_SSL_DIR}

echo starting nginx
nginx
#
# the nginx command returns immediately.
#
tail -f /dev/null


