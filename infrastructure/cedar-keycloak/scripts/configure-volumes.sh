#!/bin/bash

mkdir --parents /etc/x509/https
cp ${KEYCLOAK_KEYSTORE}/keycloak-keystore ${JBOSS_STANDALONE_CONFIG}/cedar-keycloak-keystore
cp ${KEYCLOAK_KEYSTORE}/keycloak.metadatacenter.orgx.key /etc/x509/https/tls.key
cp ${KEYCLOAK_KEYSTORE}/keycloak.metadatacenter.orgx.crt /etc/x509/https/tls.crt
