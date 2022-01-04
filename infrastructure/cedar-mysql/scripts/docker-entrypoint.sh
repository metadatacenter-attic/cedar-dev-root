#!/bin/sh

if [ ! -e ${MYSQL_SCRIPTS_DIR}/ibdata1 ]
   then
       rm -rf ${MYSQL_DATA_DIR}/*
       ${MYSQL_SCRIPTS_DIR}/configure.sh
   fi
mysqld --user=mysql --datadir=${MYSQL_DATA_DIR}
#mkdir /sleep
while [ -e /sleep ]
do
    sleep 15
done