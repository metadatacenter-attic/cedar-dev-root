#!/bin/bash

cd ${CEDAR_SOURCE}
if [ -e cedar-parent ]
then
    echo Exiting! Sources already checked out.
    exit 00
fi

git clone https://github.com/metadatacenter/cedar-parent.git/
cd cedar-parent
git clone https://github.com/metadatacenter/cedar-group-server.git/
