FROM java:latest

ARG CEDAR_VERSION
ARG CEDAR_VERSION_MODIFIER
ARG micro

ENV JAVA_SRC   /java
ADD java ${JAVA_SRC}

WORKDIR ${JAVA_SRC}

RUN java \
     -Djavax.net.ssl.trustStore=${CEDAR_HOME}/.truststore \
     -Djavax.net.ssl.trustStorePassword=${CEDAR_KEYSTORE_PASSWORD} \
     -jar target/cedar-${micro}-server-application-${CEDAR_VERSION}${CEDAR_VERSION_MODIFIER}.jar \
     server src/main/resources/config.yml
