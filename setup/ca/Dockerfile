FROM ubuntu

ARG CEDAR_CA_PASSWORD
ENV CEDAR_CA_PASSWORD  ${CEDAR_CA_PASSWORD}

ARG CEDAR_KEYSTORE_PASSWORD
ENV CEDAR_KEYSTORE_PASSWORD ${CEDAR_KEYSTORE_PASSWORD}

ARG CEDAR_KEYCLOAK_KEYSTORE_PASSWORD
ENV CEDAR_KEYCLOAK_KEYSTORE_PASSWORD  ${CEDAR_KEYCLOAK_KEYSTORE_PASSWORD}

ARG CEDAR_CA
ENV CEDAR_CA    ${CEDAR_CA}

ARG MYSQL_CERTS
ENV MYSQL_CERTS ${MYSQL_CERTS}

ARG NGINX_CERTS
ENV NGINX_CERTS ${NGINX_CERTS}

ARG KEYCLOAK_CERTS
ENV KEYCLOAK_CERTS ${KEYCLOAK_CERTS}

ARG NEO4J_CERTS
ENV NEO4J_CERTS    ${NEO4J_CERTS}

ENV CA_CONFIG_DIR /var/config
ADD config ${CA_CONFIG_DIR}

ENV CA_SCRIPTS_DIR /var/scripts
ADD scripts ${CA_SCRIPTS_DIR}

RUN ${CA_SCRIPTS_DIR}/install.sh

ENTRYPOINT ${CA_SCRIPTS_DIR}/docker-entrypoint.sh




