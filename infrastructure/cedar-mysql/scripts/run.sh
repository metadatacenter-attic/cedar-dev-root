#!/bin/sh

mkdir --parents ${MYSQL_LOG_DIR}
chown -R mysql:mysql ${MYSQL_LOG_DIR}
rm ${MYSQL_LOG_DIR}/error.log

mkdir --parents ${MYSQL_SOCK_DIR}
chown -R mysql:mysql ${MYSQL_SOCK_DIR}

mysqld --user=mysql --datadir=${MYSQL_DATA_DIR}
while `true`
do
    sleep 15
    cat ${MYSQL_LOG_DIR}/error.log
done
