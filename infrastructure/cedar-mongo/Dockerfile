FROM ubuntu:20.04
#
# Mongo Version
#
#                     4.4.10
#
# Latest: 5.05 - obtained from Docker Hub Mongo container

ARG CEDAR_MONGO_ROOT_USER_NAME
ARG CEDAR_MONGO_ROOT_USER_PASSWORD
ARG CEDAR_MONGO_APP_USER_NAME
ARG CEDAR_MONGO_APP_USER_PASSWORD

# mongod config
ENV MONGO_STORAGE_ENGINE wiredTiger
ENV MONGO_AUTH true
ENV MONGO_JOURNALING true
ENV MONGO_DB_PATH /data/db
ENV MONGO_LOG_PATH /data/log
ENV MONGO_STATE_PATH /data/state

ENV MONGO_CONFIG_DIR /opt/mongo/config
ADD config ${MONGO_CONFIG_DIR}

ENV MONGO_SCRIPTS_DIR /opt/mongo/scripts
ADD scripts $MONGO_SCRIPTS_DIR
RUN $MONGO_SCRIPTS_DIR/install.sh
RUN $MONGO_SCRIPTS_DIR/configure.sh

EXPOSE 27017
ENTRYPOINT $MONGO_SCRIPTS_DIR/entrypoint.sh
