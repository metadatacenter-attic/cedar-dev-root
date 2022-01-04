Docker version of MongoDB to be used with CEDAR

# For end-users

## Run the image for the first time

**Remark:** You need to set the environment variables first! Please see the README in the parent folder for details.

Execute the following command:

````
docker run -d \
--name mongo \
--net cedarnet \
--mount 'type=volume,src=mongo_log,dst=/data/log' \
--mount 'type=volume,src=mongo_data,dst=/data/db' \
--mount 'type=volume,src=mongo_state,dst=/data/state' \
-p ${CEDAR_MONGO_PORT}:27017 \
-e CEDAR_MONGO_ROOT_USER_NAME \
-e CEDAR_MONGO_ROOT_USER_PASSWORD \
-e CEDAR_MONGO_APP_USER_NAME \
-e CEDAR_MONGO_APP_USER_PASSWORD \
metadatacenter/cedar-mongo
````

## Stop the container

    docker stop mongo

## Start the container

    docker start mongo

## Check the logs of the container

    docker logs -f mongo

## Connect to the container

    docker exec -it mongo bash

# For developers

## Building the image

With the current release version stored in the `CEDAR_RELEASE_VERSION` environment variable, the image can be built as follows:

     docker build -t metadatacenter/cedar-mongo:${CEDAR_RELEASE_VERSION} .

## Pushing the image to CEDAR's DockerHub

Using the CEDAR DockerHub configuration instructions described [here](https://github.com/metadatacenter/cedar-conf/wiki/Configuring-Docker-to-use-the-CEDAR-Nexus-DockerHub) and with the `CEDAR_DOCKERHUB` environment variable pointing to CEDAR Nexus DockerHub host, the image can be tagged and pushed as follows:

     docker tag metadatacenter/cedar-mongo:${CEDAR_RELEASE_VERSION} ${CEDAR_DOCKERHUB}/metadatacenter/cedar-mongo:${CEDAR_RELEASE_VERSION}

     docker push ${CEDAR_DOCKERHUB}/metadatacenter/cedar-mongo:${CEDAR_RELEASE_VERSION}

The image can subsequently be pulled as follows:

     docker pull ${CEDAR_DOCKERHUB}/metadatacenter/cedar-mongo:${CEDAR_RELEASE_VERSION}
