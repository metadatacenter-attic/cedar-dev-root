#!/bin/bash

for micro in group  messaging  repo  resource  schema  artifact  \
             terminology  user valuerecommender  submission  worker \
	     openview  internals  impex
do
   mkdir -p cedar-dev-root/microServices/cedar-${micro}/java
   cp -r cedar-parent/cedar-${micro}-server \
         cedar-dev-root/microServices/cedar-${micro}/java
done
