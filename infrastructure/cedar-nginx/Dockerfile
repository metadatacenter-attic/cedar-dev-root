FROM nginx:1.17
#
#             Version 1.17
#
# Latest version: 1.20

ARG CEDAR_CERTS_VOL
ENV CEDAR_CERTS_VOL      ${CEDAR_CERTS_VOL}

ARG CEDAR_HOST
ENV CEDAR_HOST           ${CEDAR_HOST}

ENV CEDAR_SSL_DIR     /etc/nginx/cedar/ssl

ENV NGINX_SCRIPTS_DIR /scripts
ADD scripts ${NGINX_SCRIPTS_DIR}

ENV NGINX_CONF_DIR /configure
ADD config ${NGINX_CONF_DIR}

RUN ${NGINX_SCRIPTS_DIR}/configure.sh

EXPOSE 80 443


ENTRYPOINT ${NGINX_SCRIPTS_DIR}/docker-entrypoint.sh
