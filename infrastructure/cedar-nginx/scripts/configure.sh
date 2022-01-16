#!/bin/sh

waitForConnection() {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

mkdir --parents ${CEDAR_SSL_DIR}
cp ${NGINX_CONF_DIR}/module-geo.inc.conf          /etc/nginx/cedar
cp ${NGINX_CONF_DIR}/include-ssl.conf             /etc/nginx/cedar
cp ${NGINX_CONF_DIR}/server*.conf                 /etc/nginx/cedar
cp ${NGINX_CONF_DIR}/config-cedar-global.inc.conf /etc/nginx/cedar
cp ${NGINX_CONF_DIR}/nginx.conf                   /etc/nginx


echo "Creating log folders"
mkdir -p /log
cd /log
for dir in nginx cedar-artifact-server cedar-impex-server \
		 cedar-auth-server cedar-template-editor \
		 cedar-component-distribution cedar-cee-demo-angular-dist \
		 cedar-cee-docs-angular-dist cedar-openview \
		 cedar-artifact-server cedar-group-server \
		 cedar-internals-server cedar-messaging-server \
		 cedar-openview-server cedar-repo-server \
		 cedar-resource-server cedar-schema-server \
		 cedar-submission-server cedar-terminology-server \
		 cedar-user-server cedar-valuerecommender-server \
		 cedar-worker-server
do
    mkdir -p ${dir}
    touch ${dir}/nginx-error.log
    touch ${dir}/nginx-access.log
    touch ${dir}/nginx-error.log.warn
done
