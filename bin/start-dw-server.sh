#!/bin/bash
echo --------------------------------------------------------------------------------
echo Starting CEDAR $1 server
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
cd ${CEDAR_SOURCE}/cedar-parent/cedar-$1-server/cedar-$1-server-application/
logd=${CEDAR_HOME}/log/cedar-${1}-server

java \
    -Djavax.net.debug=all \
    -Djavax.net.ssl.keyStore=${CEDAR_HOME}/.keystore \
    -Djavax.net.ssl.keyStorePassword=${CEDAR_KEYSTORE_PASSWORD} \
  -jar target/cedar-$1-server-application-${CEDAR_VERSION}.jar \
  server \
  "src/main/resources/config.yml"  \
  > ${logd}/cedar-${1}-server.log 2>&1 &
echo $! > ${logd}/pid
echo --------------------------------------------------------------------------------
echo
