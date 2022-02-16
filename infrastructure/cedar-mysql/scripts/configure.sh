#!/bin/sh

waitForConnection() {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

chown mysql:mysql ${MYSQL_CERTS}/*.pem

mkdir --parents ${MYSQL_DATA_DIR}
chown -R mysql:mysql ${MYSQL_DATA_DIR}

mkdir --parents ${MYSQL_LOG_DIR}
chown -R mysql:mysql ${MYSQL_LOG_DIR}
rm ${MYSQL_LOG_DIR}/error.log

mkdir --parents ${MYSQL_SOCK_DIR}
chown -R mysql:mysql ${MYSQL_SOCK_DIR}

echo mysqld: ALL >> /etc/hosts.allow

mysqld --initialize-insecure --user=mysql --datadir=${MYSQL_DATA_DIR}

echo entering add users
${MYSQL_SCRIPTS_DIR}/add-db-users.sh


rm -rf /var/lib/mysql/*.pem

#cp ${MYSQL_CONFIG}/ca-crt.pem /var/lib/mysql/ca.pem
#cp ${MYSQL_CONFIG}/mysql.metadatacenter.orgx-crt.pem /var/lib/mysql/server-cert.pem
#cp ${MYSQL_CONFIG}/mysql.metadatacenter.orgx-key.pem /var/lib/mysql/server-key.pem

cp ${MYSQL_CONFIG}/ssl.cnf /etc/mysql/conf.d
