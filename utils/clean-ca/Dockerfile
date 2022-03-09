FROM ubuntu

ARG CEDAR_CA
ENV CEDAR_CA    ${CEDAR_CA}

ENV CA_SCRIPTS_DIR /var/scripts
ADD scripts ${CA_SCRIPTS_DIR}

ENTRYPOINT ${CA_SCRIPTS_DIR}/docker-entrypoint.sh




