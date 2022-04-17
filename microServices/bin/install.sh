#!/bin/bash

for micro in group  messaging  repo  resource  schema  artifact  \
             terminology  user valuerecommender  submission  worker \
	     openview  internals  impex
do
   echo "Installing " $micro " service..."
   cd ${CEDAR_SOURCE}
   mkdir -p cedar-dev-root/microServices/cedar-${micro}/java
   cp -r cedar-${micro}-server/cedar-${micro}-server-application/src \
         cedar-${micro}-server/cedar-${micro}-server-application/target \
         cedar-dev-root/microServices/cedar-${micro}/java/
done
