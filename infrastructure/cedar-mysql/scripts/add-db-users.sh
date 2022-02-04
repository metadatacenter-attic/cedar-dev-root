#!/bin/bash

#
# Use a temporary port so that other services don't think that mysql is up and ready.
#
TEMP_PORT=3305

cmd="mysqld --user=mysql --datadir=${MYSQL_DATA_DIR} --port=${TEMP_PORT}"
$cmd  &

mysqladmin --wait --user root password ${CEDAR_MYSQL_ROOT_PASSWORD} --port=${TEMP_PORT}

mysql -u root --password=${CEDAR_MYSQL_ROOT_PASSWORD} --port=${TEMP_PORT} <<EOF

CREATE DATABASE IF NOT EXISTS ${CEDAR_KEYCLOAK_MYSQL_DB}; 
CREATE  USER "${CEDAR_KEYCLOAK_MYSQL_USER}" IDENTIFIED BY "${CEDAR_KEYCLOAK_MYSQL_PASSWORD}";
GRANT ALL PRIVILEGES ON ${CEDAR_KEYCLOAK_MYSQL_DB}.* TO "${CEDAR_KEYCLOAK_MYSQL_USER}";

CREATE DATABASE IF NOT EXISTS ${CEDAR_LOG_MYSQL_DB};
CREATE USER "${CEDAR_LOG_MYSQL_USER}" IDENTIFIED BY "${CEDAR_LOG_MYSQL_PASSWORD}";
GRANT ALL PRIVILEGES ON ${CEDAR_LOG_MYSQL_DB}.* TO "${CEDAR_LOG_MYSQL_USER}";

CREATE DATABASE IF NOT EXISTS ${CEDAR_MESSAGING_MYSQL_DB};
CREATE USER "${CEDAR_MESSAGING_MYSQL_USER}" IDENTIFIED BY "${CEDAR_MESSAGING_MYSQL_PASSWORD}";
GRANT ALL PRIVILEGES ON ${CEDAR_MESSAGING_MYSQL_DB}.* TO "${CEDAR_MESSAGING_MYSQL_USER}";

SET GLOBAL ssl_ca   = "/opt/mysql/config/ca-crt.pem";
SET GLOBAL ssl_cert = "/opt/mysql/config/mysql.metadatacenter.orgx-crt.pem";
SET GLOBAL ssl_key  = "/opt/mysql/config/mysql.metadatacenter.orgx-key.pem";

FLUSH PRIVILEGES;
EOF

mysqladmin --user root --password=${CEDAR_MYSQL_ROOT_PASSWORD} --port=${TEMP_PORT} shutdown
