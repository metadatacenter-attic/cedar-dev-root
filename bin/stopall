#!/bin/sh

files=`find ${CEDAR_HOME}/log -name pid -print`
kill `cat ${files}`
find ${CEDAR_HOME}/log -name pid -exec rm {} \;
