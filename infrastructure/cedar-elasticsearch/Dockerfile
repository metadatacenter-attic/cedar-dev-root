FROM elasticsearch:6.8.20
#
# ElasticSearch version
#                                6.8.20
#
# Latest: 7.16.1

ADD config/elasticsearch.yml /usr/share/elasticsearch/config/


ENV ELASTIC_SCRIPTS_DIR /opt/elastic/scripts
ADD scripts ELASTIC_SCRIPTS_DIR
#RUN ${ELASTIC_SCRIPTS_DIR}/configure.sh

EXPOSE 9200
EXPOSE 9300

#ENTRYPOINT[ "${ELASTIC_SCRIPTS_DIR}/run.sh" ]