#!/bin/sh

#mkdir ~/.m2
#cp ${KEYCLOAK_CONFIG_DIR}/m2/settings.xml  ~/.m2
#mvn org.apache.maven.plugins:maven-dependency-plugin:3.1.1:get -DrepoUrl=https://nexus.bmir.stanford.edu/ -Dartifact=org.metadatacenter:cedar-keycloak-event-listener:${CEDAR_VERSION}
#mvn org.apache.maven.plugins:maven-dependency-plugin:3.1.1:copy -Dartifact=org.metadatacenter:cedar-keycloak-event-listener:${CEDAR_VERSION}:jar -DoutputDirectory=/opt/jboss/keycloak/providers -Dmdep.useBaseVersion=true



cp -r ${KEYCLOAK_CONFIG_DIR}/themes/cedar-03 /opt/jboss/keycloak/themes/cedar-03

mkdir -p /opt/jboss/realm-import
mkdir -p /opt/jboss/realm-export
chown -R jboss:jboss /opt/jboss/realm-export
cp ${KEYCLOAK_CONFIG_DIR}/keycloak-realm.CEDAR.development.20201020.json /opt/jboss/realm-import/
chown -R jboss:jboss /opt/jboss/realm-import
mkdir -p /opt/jboss/keycloak/standalone/log
chown -R jboss:jboss /opt/jboss/keycloak/standalone/log

#cp ${KEYCLOAK_SCRIPTS_DIR}/wait-and-init-mysql.py /opt/jboss/

cp ${KEYCLOAK_CONFIG_DIR}/standalone.xml /opt/jboss/keycloak/standalone/configuration/standalone.xml

cp -r ${KEYCLOAK_SCRIPTS_DIR}/custom-scripts/ /opt/jboss/startup-scripts/
cp    ${KEYCLOAK_SCRIPTS_DIR}/tools/listener.cli /opt/jboss/tools/listener.cli

cd /opt/jboss/keycloak/standalone/configuration
keytool -genkey -alias auth.metadatacenter.orgx \
        -keyalg RSA -keystore cedar.keycloak.keystore -validity 3650 <<EOF
password
password
auth.metadatacenter.orgx
BMIR
med
Stanford
California
US
yes
EOF
cp ${KEYCLOAK_SCRIPTS_DIR}/cedar-keycloak-event-listener.jar ${CEDAR_KEYCLOAK_HOME}/standalone/deployments/

${CEDAR_KEYCLOAK_HOME}/bin/add-user-keycloak.sh -r master \
         -u ${CEDAR_KEYCLOAK_ADMIN_USER} -p ${CEDAR_KEYCLOAK_ADMIN_PASSWORD}
