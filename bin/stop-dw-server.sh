#!/bin/bash

echo --------------------------------------------------------------------------------
echo Stopping CEDAR $1 server
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
logd=${CEDAR_HOME}/log/cedar-${1}-server

kill `cat ${logd}/pid`
