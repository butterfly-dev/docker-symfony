FROM php:7.1-fpm

RUN apt-get update && \
    apt-get install -y \
        git \
        zip \
        unzip \
        curl \
        libicu-dev \
        libcurl3-dev \
        libxml2-dev \
        libssl-dev

###
# DEFINE LOCAL
###
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN "date"

###
# INSTALL ICU FOR INTL AND CONFIGURE INTL
###
RUN curl -sS -o /tmp/icu.tar.gz -L http://download.icu-project.org/files/icu4c/58.2/icu4c-58_2-src.tgz && \
    tar -zxf /tmp/icu.tar.gz -C /tmp && \
    cd /tmp/icu/source && \
    sed -i 's/xlocale/locale/' i18n/digitlst.cpp && \
    ./configure --prefix=/usr/local && \
    make && make install && \
    docker-php-ext-configure intl --with-icu-dir=/usr/local

####
# INSTALL PHP EXTENSION
###
RUN docker-php-ext-install pdo pdo_mysql opcache intl bcmath curl xml mbstring zip

###
# INSTALL AND ENABLE APCU
###
RUN pecl install apcu && \
    echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini

###
# MONGODB
###
RUN pecl install mongodb && \
    echo "[mongodb]" >> /usr/local/etc/php/conf.d/mongodb.ini && \
    echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini


###
# INSTALL AND CONFIGURE XDEBUG
###
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini


###
# COPY CUSTOME PHP.INI
###
COPY php.ini /usr/local/etc/php

###
# PERMISSION USER/GROUP
###
RUN usermod -u 1000 www-data

###
# INSTALL COMPOSER
##
RUN mkdir -p /usr/local/bin /var/www/.composer && \
    chown -R www-data:www-data /usr/local/bin /var/www/.composer && \
    runuser www-data -s /bin/bash -c "curl -sS https://getcomposer.org/installer \
                                      | php -- --install-dir=/usr/local/bin --filename=composer" && \
    runuser www-data -s /bin/bash -c "composer --version"

###
# CLEAN CONTAINER
###
RUN apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

###
# DEFINE WORKDIR
##
WORKDIR /var/www/symfony
