Docker version of Neo4j to be used with CEDAR

# For end-users

## Run the image for the first time

**Remark:** You need to set the environment variables first! Please see the README in the parent folder for details.

Execute the following command:

````
docker run -d \
--name neo4j \
--net cedarnet \
--mount 'type=volume,src=neo4j_log,dst=/logs' \
--mount 'type=volume,src=neo4j_data,dst=/data' \
--mount 'type=volume,src=neo4j_state,dst=/state' \
-p ${CEDAR_NEO4J_REST_PORT}:7474 \
-p ${CEDAR_NEO4J_BOLT_PORT}:7687 \
-e CEDAR_NEO4J_USER_NAME \
-e CEDAR_NEO4J_USER_PASSWORD \
-e CEDAR_HOST \
-e CEDAR_ADMIN_USER_API_KEY \
metadatacenter/cedar-neo4j
````

## Stop the container

    docker stop neo4j

## Start the container

    docker start neo4j

## Check the logs of the container

    docker logs -f neo4j

## Connect to the container

    docker exec -it neo4j bash

# For developers

## Building the image

With the current release version stored in the `CEDAR_RELEASE_VERSION` environment variable, the image can be built as follows:

    chmod a+x scripts/docker-entrypoint-wrapper.sh
    chmod a+x scripts/neo4j-init.sh
    docker build -t metadatacenter/cedar-neo4j:${CEDAR_RELEASE_VERSION} .

## Pushing the image to CEDAR's DockerHub

Using the CEDAR DockerHub configuration instructions described [here](https://github.com/metadatacenter/cedar-conf/wiki/Configuring-Docker-to-use-the-CEDAR-Nexus-DockerHub) and with the `CEDAR_DOCKERHUB` environment variable pointing to CEDAR Nexus DockerHub host, the image can be tagged and pushed as follows:

    docker tag metadatacenter/cedar-neo4j:${CEDAR_RELEASE_VERSION} ${CEDAR_DOCKERHUB}/metadatacenter/cedar-neo4j:${CEDAR_RELEASE_VERSION}

    docker push ${CEDAR_DOCKERHUB}/metadatacenter/cedar-neo4j:${CEDAR_RELEASE_VERSION}

The image can subsequently be pulled as follows:

    docker pull ${CEDAR_DOCKERHUB}/metadatacenter/cedar-neo4j:${CEDAR_RELEASE_VERSION}
