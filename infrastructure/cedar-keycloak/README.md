Docker version of Keycloak to be used with CEDAR

# For end-users

## Run the image for the first time

**Remark:** You need to set the environment variables first! Please see the README in the parent folder for details.

Execute the following command:

````
docker run -d \
--name keycloak \
--net cedarnet \
--add-host "resource.${CEDAR_HOST}:${CEDAR_DOCKER_HOST}" \
--mount 'type=volume,src=keycloak_log,dst=/opt/jboss/keycloak/standalone/log' \
-p ${CEDAR_KEYCLOAK_HTTPS_PORT}:8443 \
-p ${CEDAR_KEYCLOAK_HTTP_PORT}:8080 \
-e CEDAR_MYSQL_ROOT_PASSWORD \
-e CEDAR_KEYCLOAK_MYSQL_USER \
-e CEDAR_KEYCLOAK_MYSQL_PASSWORD \
-e CEDAR_KEYCLOAK_MYSQL_PORT \
-e CEDAR_KEYCLOAK_MYSQL_HOST \
-e CEDAR_KEYCLOAK_MYSQL_DB \
-e CEDAR_KEYCLOAK_ADMIN_USER \
-e CEDAR_KEYCLOAK_ADMIN_PASSWORD \
-e CEDAR_ADMIN_USER_API_KEY \
-e CEDAR_HOST \
-e CEDAR_NET_GATEWAY \
-e CEDAR_RESOURCE_HTTP_PORT \
metadatacenter/cedar-keycloak
````

## Stop the container

    docker stop keycloak

## Start the container

    docker start keycloak

## Check the logs of the container

    docker logs -f keycloak

## Connect to the container

    docker exec -it keycloak bash

# For developers

## Building the image

With the current release version stored in the `CEDAR_RELEASE_VERSION` environment variable, the image can be built as follows:

     docker build -t metadatacenter/cedar-keycloak:${CEDAR_RELEASE_VERSION} .

## Pushing the image to CEDAR's DockerHub

Using the CEDAR DockerHub configuration instructions described [here](https://github.com/metadatacenter/cedar-conf/wiki/Configuring-Docker-to-use-the-CEDAR-Nexus-DockerHub) and with the `CEDAR_DOCKERHUB` environment variable pointing to CEDAR Nexus DockerHub host, the image can be tagged and pushed as follows:

     docker tag metadatacenter/cedar-keycloak:${CEDAR_RELEASE_VERSION} ${CEDAR_DOCKERHUB}/metadatacenter/cedar-keycloak:${CEDAR_RELEASE_VERSION}

     docker push ${CEDAR_DOCKERHUB}/metadatacenter/cedar-keycloak:${CEDAR_RELEASE_VERSION}

The image can subsequently be pulled as follows:

     docker pull ${CEDAR_DOCKERHUB}/metadatacenter/cedar-keycloak:${CEDAR_RELEASE_VERSION}
