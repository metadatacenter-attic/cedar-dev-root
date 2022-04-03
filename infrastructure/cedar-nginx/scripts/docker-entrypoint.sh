#!/bin/sh

if [ -e ${FIRST} ]
then
    echo "Configuring volumes..."
    ${NGINX_SCRIPTS_DIR}/configure-volumes.sh
    rm ${FIRST}
fi    
echo starting nginx
nginx
#
# the nginx command returns immediately.
#
tail -f /dev/null


