#!/bin/sh

waitForConnection()  {
    echo Waiting for connection...
    echo ContainerId: `hostname`
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 2
    done
}

#waitForConnection
mv ${KEYCLOAK_CONFIG_DIR}/jdbc-module.xml \
   ${CEDAR_KEYCLOAK_HOME}/modules/system/layers/base/com/mysql/jdbc/main/module.xml

cp -r ${KEYCLOAK_CONFIG_DIR}/themes/cedar-03 /opt/jboss/keycloak/themes/cedar-03

mkdir -p /opt/jboss/realm-import
mkdir -p /opt/jboss/realm-export
chown -R jboss:jboss /opt/jboss/realm-import
chown -R jboss:jboss /opt/jboss/realm-export
cp ${KEYCLOAK_CONFIG_DIR}/keycloak-realm.CEDAR.development.20201020.json /opt/jboss/realm-import/
chown -R jboss:jboss /opt/jboss/realm-import
mkdir -p /opt/jboss/keycloak/standalone/log
chown -R jboss:jboss /opt/jboss/keycloak/standalone/log

cp ${KEYCLOAK_CONFIG_DIR}/standalone.xml ${JBOSS_STANDALONE_CONFIG}/standalone.xml

cp -r ${KEYCLOAK_SCRIPTS_DIR}/custom-scripts/ /opt/jboss/startup-scripts/
cp    ${KEYCLOAK_SCRIPTS_DIR}/tools/listener.cli /opt/jboss/tools/listener.cli

cp ${KEYCLOAK_SCRIPTS_DIR}/cedar-keycloak-event-listener.jar ${CEDAR_KEYCLOAK_HOME}/standalone/deployments/

${CEDAR_KEYCLOAK_HOME}/bin/add-user-keycloak.sh -r master \
         -u ${CEDAR_KEYCLOAK_ADMIN_USER} -p ${CEDAR_KEYCLOAK_ADMIN_PASSWORD}

export KEYCLOAK_IMPORT=/opt/jboss/realm-import/keycloak-realm.CEDAR.development.20201020.json

touch /tmp/firstRun
