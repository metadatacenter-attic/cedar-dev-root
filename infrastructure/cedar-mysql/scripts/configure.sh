#!/bin/sh

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

#mkdir /sleep
while [ -e /sleep ]
do
    sleep 5
done
