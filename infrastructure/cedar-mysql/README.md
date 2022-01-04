Docker version of MySQL to be used with CEDAR

# For end-users

## Run the image for the first time

**Remark:** You need to set the environment variables first! Please see the README in the parent folder for details.

Execute the following command:

````
docker run -d \
--name mysql \
--net cedarnet \
--mount 'type=volume,src=mysql_log,dst=/var/log/mysql' \
--mount 'type=volume,src=mysql_data,dst=/var/lib/mysql' \
-p ${CEDAR_KEYCLOAK_MYSQL_PORT}:3306 \
-e CEDAR_MYSQL_ROOT_PASSWORD \
-e CEDAR_NET_GATEWAY \
metadatacenter/cedar-mysql
````

## Stop the container

    docker stop mysql

## Start the container

    docker start mysql

## Check the logs of the container

    docker logs -f mysql

## Connect to the container

    docker exec -it mysql bash

# For developers

## Building the image

With the current release version stored in the `CEDAR_RELEASE_VERSION` environment variable, the image can be built as follows:

     docker build -t metadatacenter/cedar-mysql:${CEDAR_RELEASE_VERSION} .

## Pushing the image to CEDAR's DockerHub

Using the CEDAR DockerHub configuration instructions described [here](https://github.com/metadatacenter/cedar-conf/wiki/Configuring-Docker-to-use-the-CEDAR-Nexus-DockerHub) and with the `CEDAR_DOCKERHUB` environment variable pointing to CEDAR Nexus DockerHub host, the image can be tagged and pushed as follows:

     docker tag metadatacenter/cedar-mysql:${CEDAR_RELEASE_VERSION} ${CEDAR_DOCKERHUB}/metadatacenter/cedar-mysql:${CEDAR_RELEASE_VERSION}

     docker push ${CEDAR_DOCKERHUB}/metadatacenter/cedar-mysql:${CEDAR_RELEASE_VERSION}

The image can subsequently be pulled as follows:

     docker pull ${CEDAR_DOCKERHUB}/metadatacenter/cedar-mysql:${CEDAR_RELEASE_VERSION}
