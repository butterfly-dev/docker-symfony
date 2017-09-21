FROM debian:jessie

###
# INSTALL PACKAGE: nginx
###
RUN apt-get update && apt-get install -y \
    nginx

###
# ADD COBFIGURATION NGINX
###
ADD nginx.conf /etc/nginx/
ADD symfony.conf /etc/nginx/sites-available/
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony
RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

###
# PREMISSION USER/GROUP
###
RUN usermod -u 1000 www-data

###
# CLEAN CONTAINER
###
RUN apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 80
EXPOSE 443

CMD ["nginx"]
