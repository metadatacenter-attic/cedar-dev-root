#!/bin/bash
set -e

echo "Creating log folders"
cd "${LOGDIR}"
mkdir -p nginx-global

mkdir -p nginx-artifact
mkdir -p nginx-auth
mkdir -p nginx-frontend
mkdir -p nginx-frontend-component
mkdir -p nginx-frontend-openview
mkdir -p nginx-group
mkdir -p nginx-internals
mkdir -p nginx-messaging
mkdir -p nginx-open
mkdir -p nginx-openview
mkdir -p nginx-repo
mkdir -p nginx-resource
mkdir -p nginx-schema
mkdir -p nginx-submission
mkdir -p nginx-terminology
mkdir -p nginx-user
mkdir -p nginx-valuerecommender
mkdir -p nginx-worker 


echo "Executing sed"
echo "Using CEDAR_HOST              :${CEDAR_HOST}"
echo "Using CEDAR_MICROSERVICE_HOST :${CEDAR_MICROSERVICE_HOST}"
echo "Using CEDAR_KEYCLOAK_HOST     :${CEDAR_KEYCLOAK_HOST}"
echo "Using CEDAR_FRONTEND_HOST     :${CEDAR_FRONTEND_HOST}"

for filename in /etc/nginx/conf.d/*inc.conf; do
  sed -i 's/<cedar.CEDAR_HOST>/'${CEDAR_HOST}'/g' $filename
  sed -i 's/<cedar.CEDAR_MICROSERVICE_HOST>/'${CEDAR_MICROSERVICE_HOST}'/g' $filename
done

sed -i 's/<cedar.CEDAR_KEYCLOAK_HOST>/'${CEDAR_KEYCLOAK_HOST}'/g' /etc/nginx/conf.d/server-auth.inc.conf
sed -i 's/<cedar.CEDAR_FRONTEND_HOST>/'${CEDAR_FRONTEND_HOST}'/g' /etc/nginx/conf.d/frontend-cedar.inc.conf
sed -i 's/<cedar.CEDAR_FRONTEND_HOST>/'${CEDAR_FRONTEND_HOST}'/g' /etc/nginx/conf.d/frontend-component.inc.conf
sed -i 's/<cedar.CEDAR_FRONTEND_HOST>/'${CEDAR_FRONTEND_HOST}'/g' /etc/nginx/conf.d/frontend-openview.inc.conf

exec "$@"
