FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    zlib1g-dev \
    libldap2-dev \
    libonig-dev \
    libpq-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libmemcached-dev \
    libtidy-dev \
    libxpm-dev \
    libgd-dev \
    libgmp-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
    gd \
    intl \
    pdo_pgsql \
    mysqli \
    zip \
    ldap \
    opcache \
    gmp \
    tidy \
    calendar \
    exif \
    gettext \
    sockets \
    pdo \
    pdo_mysql

RUN a2enmod rewrite

WORKDIR /var/www/html

RUN rm -fR /etc/apache2/sites-available/000-default.conf
COPY 000-default.conf /etc/apache2/sites-available/

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["apache2-foreground"]
