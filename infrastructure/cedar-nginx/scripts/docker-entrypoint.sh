#!/bin/sh

${NGINX_SCRIPTS_DIR}/configure-volumes.sh
echo starting nginx
nginx
#
# the nginx command returns immediately.
#
tail -f /dev/null


