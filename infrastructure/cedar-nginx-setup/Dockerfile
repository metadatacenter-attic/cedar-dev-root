FROM nginx:1.13.12

# Add the entry point
ADD scripts/docker-entrypoint.sh /
ADD scripts/get-certificates.sh /

# Add nginx config
ADD config/*.conf /etc/nginx/conf.d/

RUN apt-get update
RUN apt-get install -y python-certbot-nginx

ADD config/roots /usr/share/nginx/

VOLUME /etc/letsencrypt

CMD ["nginx", "-g", "daemon off;"]

ENTRYPOINT [ "/docker-entrypoint.sh" ]
