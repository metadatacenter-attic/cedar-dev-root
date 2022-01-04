Docker version of Nginx for CEDAR 

# For end-users

## Run the image for the first time

**Remark:** You need to set the environment variables first! Please see the README in the parent folder for details.

Execute the following command:

````
docker run -d \
--name nginx \
--net cedarnet \
--mount 'type=volume,src=nginx_log,dst=/etc/nginx/log' \
--mount 'type=volume,src=cedar_cert,dst=/usr/local/etc/certificates' \
-p ${CEDAR_NGINX_HTTP_PORT}:80 \
-p ${CEDAR_NGINX_HTTPS_PORT}:443 \
-e CEDAR_HOST \
-e CEDAR_MICROSERVICE_HOST \
-e CEDAR_KEYCLOAK_HOST \
-e CEDAR_FRONTEND_HOST \
metadatacenter/cedar-nginx
````

## Stop the container

    docker stop nginx

## Start the container

    docker start nginx

## Check the logs of the container

    docker logs -f nginx

## Connect to the container

    docker exec -it nginx bash

# For developers

## Building the image

With the current release version stored in the `CEDAR_RELEASE_VERSION` environment variable, the image can be built as follows:

     docker build -t metadatacenter/cedar-nginx:${CEDAR_RELEASE_VERSION} .

## Pushing the image to CEDAR's DockerHub

Using the CEDAR DockerHub configuration instructions described [here](https://github.com/metadatacenter/cedar-conf/wiki/Configuring-Docker-to-use-the-CEDAR-Nexus-DockerHub) and with the `CEDAR_DOCKERHUB` environment variable pointing to CEDAR Nexus DockerHub host, the image can be tagged and pushed as follows:

     docker tag metadatacenter/cedar-nginx:${CEDAR_RELEASE_VERSION} ${CEDAR_DOCKERHUB}/metadatacenter/cedar-nginx:${CEDAR_RELEASE_VERSION}

     docker push ${CEDAR_DOCKERHUB}/metadatacenter/cedar-nginx:${CEDAR_RELEASE_VERSION}

The image can subsequently be pulled as follows:

     docker pull ${CEDAR_DOCKERHUB}/metadatacenter/cedar-nginx:${CEDAR_RELEASE_VERSION}
