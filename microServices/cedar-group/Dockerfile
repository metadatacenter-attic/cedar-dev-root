FROM java:latest

ARG micro
ENV micro      ${micro}

ENV JAVA_SRC   /java
ADD java ${JAVA_SRC}

WORKING_DIR ${JAVA_SRC}/cedar-${micro}-server/cedar-${micro}-server-application

RUN java \
     -Djavax.net.ssl.trustStore=${CEDAR_HOME}/.truststore \
     -Djavax.net.ssl.trustStorePassword=${CEDAR_KEYSTORE_PASSWORD} \
     -JAR target/cedar-${micro}-server-application-${CEDAR_VERSION}.jar \
     server src/main/resources/config.yml
