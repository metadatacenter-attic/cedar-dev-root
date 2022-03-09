#!/bin/bash

mkdir /var/lib/neo4j/certificates
cp ${NEO4J_CERTS}/neo4j.metadatacenter.orgx.crt \
           /var/lib/neo4j/certificates/neo4j.cert
cp ${NEO4J_CERTS}/neo4j.metadatacenter.orgx.key \
           /var/lib/neo4j/certificates/neo4j.key

chown -R neo4j:neo4j /var/lib/neo4j/certificates
