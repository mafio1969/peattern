# php/Dockerfile

FROM hermsi/alpine-fpm-php:7.4
RUN chmod +x /usr/bin/wait-for-it
RUN apk --update --no-cache add git
RUN docker-php-ext-install pdo_mysql
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug-3.0.2 \
    && docker-php-ext-enable xdebug

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


ENV ALPINE_MIRROR "http://dl-cdn.alpinelinux.org/alpine"
RUN echo "${ALPINE_MIRROR}/edge/main" >> /etc/apk/repositories
RUN apk add --no-cache nodejs-current yarn npm --repository="http://dl-cdn.alpinelinux.org/alpine/edge/community"
RUN node --version
RUN rm /var/cache/apk/*

ENV GROUP_ID=1000 \
    USER_ID=1000
ENV USER=docker
RUN addgroup "docker"

RUN adduser \
    --disabled-password \
    --gecos "" \
    --ingroup "$USER" \
    --no-create-home \
    --uid "$USER_ID" \
    "$USER"
RUN docker-php-ext-install mysqli pdo_mysql && docker-php-ext-enable pdo_mysql
COPY supervisord-app.conf /etc/supervisord.conf

WORKDIR /app

EXPOSE 9000