#!/bin/sh

waitForConnection() {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

chmod 0770 /var/run/mysqld
chown mysql:mysql /var/run/mysqld

mkdir --parents ${MYSQL_DATA_DIR}
chown -R mysql:mysql ${MYSQL_DATA_DIR}

mkdir --parents ${MYSQL_LOG_DIR}
chown -R mysql:mysql ${MYSQL_LOG_DIR}
rm -f ${MYSQL_LOG_DIR}/error.log

mkdir --parents ${MYSQL_SOCK_DIR}
chown -R mysql:mysql ${MYSQL_SOCK_DIR}

echo mysqld: ALL >> /etc/hosts.allow

cp ${MYSQL_CONFIG}/ssl.cnf /etc/mysql/conf.d
