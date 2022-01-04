Docker version of Elasticsearch to be used with CEDAR

# For end-users

## Run the image for the first time

**Remark:** You need to set the environment variables first! Please see the README in the parent folder for details.

Execute the following command:

````
docker run -d \
--name elasticsearch \
--net cedarnet \
--mount 'type=volume,src=elasticsearch_log,dst=/usr/share/elasticsearch/logs' \
--mount 'type=volume,src=elasticsearch_data,dst=/usr/share/elasticsearch/data' \
-p ${CEDAR_ELASTICSEARCH_REST_PORT}:9200 \
metadatacenter/cedar-elasticsearch
````

## Stop the container

    docker stop elasticsearch

## Start the container

    docker start elasticsearch

## Check the logs of the container

    docker logs -f elasticsearch

## Connect to the container

    docker exec -it elasticsearch bash

# For developers

## Building the image

With the current release version stored in the `CEDAR_RELEASE_VERSION` environment variable, the image can be built as follows:

     docker build -t metadatacenter/cedar-elasticsearch:${CEDAR_RELEASE_VERSION} .

## Pushing the image to CEDAR's DockerHub

Using the CEDAR DockerHub configuration instructions described [here](https://github.com/metadatacenter/cedar-conf/wiki/Configuring-Docker-to-use-the-CEDAR-Nexus-DockerHub) and with the `CEDAR_DOCKERHUB` environment variable pointing to CEDAR Nexus DockerHub host, the image can be tagged and pushed as follows:

     docker tag metadatacenter/cedar-elasticsearch:${CEDAR_RELEASE_VERSION} ${CEDAR_DOCKERHUB}/metadatacenter/cedar-elasticsearch:${CEDAR_RELEASE_VERSION}

     docker push ${CEDAR_DOCKERHUB}/metadatacenter/cedar-elasticsearch:${CEDAR_RELEASE_VERSION}

The image can subsequently be pulled as follows:

     docker pull ${CEDAR_DOCKERHUB}/metadatacenter/cedar-elasticsearch:${CEDAR_RELEASE_VERSION}
