FROM	php:8.0.2-fpm-alpine

LABEL	maintainer="https://github.com/mafio69"

ARG     PHPREDIS_VERSION="${PHPREDIS_VERSION:-5.1.1}"
ENV     PHPREDIS_VERSION="${PHPREDIS_VERSION}"

#ADD     http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz /tmp/
#ADD     https://github.com/phpredis/phpredis/archive/${PHPREDIS_VERSION}.tar.gz /tmp/
COPY wait-for-it.sh /usr/bin/wait-for-it

RUN     set -x                           && \
        \
        apk update                       && \
        \
        apk upgrade                      && \
        \
        docker-php-source extract        && \
        \
        apk add --no-cache                  \
            --virtual .build-dependencies   \
                $PHPIZE_DEPS                \
                cyrus-sasl-dev              \
                git                         \
                autoconf                    \
                g++                         \
                libtool                     \
                make                        \
                libgcrypt                   \
                pcre-dev                 && \
        \
        apk add --no-cache                  \
            tini                            \
            libintl                         \
            icu                             \
            icu-dev                         \
            libxml2-dev                     \
            postgresql-dev                  \
            freetype-dev                    \
            libjpeg-turbo-dev               \
            libpng-dev                      \
            gmp                             \
            gmp-dev                         \
            libmemcached-dev                \
            imagemagick-dev                 \
            libzip-dev                       \
            zlib-dev                        \
            libssh2-dev                     \
            libwebp-dev                     \
            libxpm-dev                      \
            libvpx-dev                      \
            libxslt-dev                     \
            libmcrypt-dev                && \
#        tar xfz /tmp/${PHPREDIS_VERSION}.tar.gz   && \
#        \
#        mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis    && \
#        \
        git clone https://github.com/php-memcached-dev/php-memcached.git /usr/src/php/ext/memcached/    && \
        \
        docker-php-ext-configure memcached      &&  \
        \
        docker-php-ext-configure exif           && \
        \
        docker-php-ext-configure gd             \
            --with-freetype=/usr/include/       \
            --with-xpm=/usr/include/            \
            --with-webp=/usr/include/           \
            --with-jpeg=/usr/include/       &&  \
        \
        docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" \
            intl                                                \
            bcmath                                              \
            xsl                                                 \
            zip                                                 \
            soap                                                \
            mysqli                                              \
            pdo                                                 \
            pdo_mysql                                           \
            pdo_pgsql                                           \
            gmp                                                 \
#            redis                                               \
            iconv                                               \
            gd                                                  \
            memcached                                       &&  \
#        \
#        tar -xvzf                                                       \
#            /tmp/ioncube_loaders_lin_x86-64.tar.gz                      \
#            -C /tmp/                                                &&  \
#        \
#        mkdir -p /usr/local/php/ext/ioncube                         &&  \
#        \
#        cp -a /tmp/ioncube/ioncube_loader_lin_${PHP_VERSION%.*}.so      \
#            /usr/local/php/ext/ioncube/ioncube_loader.so            &&  \
        \
        docker-php-ext-configure opcache --enable-opcache           &&  \
        \
        docker-php-ext-install opcache                              &&  \
        \
        docker-php-ext-install exif                                 &&  \
        \
        git clone \
            https://github.com/krakjoe/apcu.git \
            /usr/src/php/ext/apcu                                   &&  \
        git clone \
            https://github.com/Imagick/imagick.git \
            /usr/src/php/ext/imagick                                &&  \
        docker-php-ext-install apcu imagick                         &&  \
        docker-php-ext-enable apcu imagick                          &&  \
        \
        apk del .build-dependencies                                 &&  \
        \
        docker-php-source delete                                    &&  \
        \
        rm -rf /tmp/* /var/cache/apk/*

RUN apk --update add wget \
  curl \
  git \
  grep \
  build-base \
  libmemcached-dev \
  libmcrypt-dev \
  libxml2-dev \
  imagemagick-dev \
  pcre-dev \
  libtool \
  make \
  php7-mysqli \
  php7-pdo_mysql \
  autoconf \
  g++ \
  cyrus-sasl-dev \
  libgsasl-dev \
  supervisor

RUN chmod +x /usr/bin/wait-for-it
RUN apk --update --no-cache add git
RUN docker-php-ext-install pdo_mysql
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug-3.0.2 \
    && docker-php-ext-enable xdebug
# set recommended PHP.ini settings
# https://secure.php.net/manual/en/opcache.installation.php
# https://secure.php.net/manual/en/apcu.configuration.php
COPY    ["conf.d/05-apcu-recommended.ini", "conf.d/05-opcache-recommended.ini", "conf.d/05-security-recommended.ini", "/usr/local/etc/php/conf.d/"]

CMD     ["php-fpm"]