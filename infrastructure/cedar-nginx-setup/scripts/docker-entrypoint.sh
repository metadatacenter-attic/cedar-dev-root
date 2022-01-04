#!/bin/bash
set -e

echo "Executing sed"
echo "Using CEDAR_HOST              :${CEDAR_HOST}"

for filename in /etc/nginx/conf.d/*cedar.conf; do
  sed -i 's/<cedar.CEDAR_HOST>/'${CEDAR_HOST}'/g' $filename
done

exec "$@"

