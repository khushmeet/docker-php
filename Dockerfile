FROM php:7.4-apache

RUN apt-get update && apt-get install -y gnupg2
RUN apt-get install -y zlib1g-dev libicu-dev g++ libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev libfreetype6-dev
RUN apt-get install -y libzip-dev libxslt-dev libonig-dev
RUN docker-php-ext-install zip
RUN docker-php-ext-configure intl
RUN docker-php-ext-install mysqli pdo pdo_mysql intl
RUN pecl install  xdebug 
RUN docker-php-ext-enable xdebug
RUN docker-php-ext-configure gd  --with-webp=/usr/include/ --with-jpeg=/usr/include/ --with-xpm=/usr/include/ --with-freetype=/usr/include/ 
RUN docker-php-ext-install gd
RUN docker-php-ext-install gettext bcmath xsl mbstring
RUN mkdir -p /app/
RUN chmod -R 777 /app/
RUN chown -R www-data:www-data /app/
RUN mkdir -p /etc/apache2/logs/
RUN chmod 777 /etc/apache2/logs/
COPY ./000-default.conf /etc/apache2/sites-available/
COPY ./001-sub.conf /etc/apache2/sites-available/

