FROM neo4j:3.5.3

RUN apk --no-cache add curl netcat-openbsd

WORKDIR /var/lib/neo4j

RUN mkdir /state

VOLUME /logs
VOLUME /state

ADD scripts/docker-entrypoint-wrapper.sh /docker-entrypoint-wrapper.sh
ADD scripts/neo4j-init.sh /neo4j-init.sh
ADD config/neo4j-create-cedar-admin.json /neo4j-create-cedar-admin.json

ENTRYPOINT ["/docker-entrypoint-wrapper.sh"]
CMD ["neo4j"]
