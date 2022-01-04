Docker version of Nginx for CEDAR 

# For end-users

## Run the image for the first time

**Remark:** You need to set the environment variables first! Please see the README in the parent folder for details.

Execute the following command:

````
docker run -d \
--name nginx-setup \
--net cedarnet \
--mount 'type=volume,src=nginx_log,dst=/etc/nginx/log' \
--mount 'type=volume,src=cedar_cert,dst=/etc/letsencrypt' \
-e CEDAR_HOST \
-p 80:80 \
metadatacenter/cedar-nginx-setup
````

## Stop the container

    docker stop nginx-setup

## Start the container

    docker start nginx-setup

## Check the logs of the container

    docker logs -f nginx-setup

## Connect to the container

    docker exec -it nginx-setup bash

# For developers

## Building the image

With the current release version stored in the `CEDAR_RELEASE_VERSION` environment variable, the image can be built as follows:

     docker build -t metadatacenter/cedar-nginx-setup:${CEDAR_RELEASE_VERSION} .

## Pushing the image to CEDAR's DockerHub

Using the CEDAR DockerHub configuration instructions described [here](https://github.com/metadatacenter/cedar-conf/wiki/Configuring-Docker-to-use-the-CEDAR-Nexus-DockerHub) and with the `CEDAR_DOCKERHUB` environment variable pointing to CEDAR Nexus DockerHub host, the image can be tagged and pushed as follows:

     docker tag metadatacenter/cedar-nginx-setup:${CEDAR_RELEASE_VERSION} ${CEDAR_DOCKERHUB}/metadatacenter/cedar-nginx-setup:${CEDAR_RELEASE_VERSION}

     docker push ${CEDAR_DOCKERHUB}/metadatacenter/cedar-nginx-setup:${CEDAR_RELEASE_VERSION}

The image can subsequently be pulled as follows:

     docker pull ${CEDAR_DOCKERHUB}/metadatacenter/cedar-nginx-setup:${CEDAR_RELEASE_VERSION}
