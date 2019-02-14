FROM alpine:edge

MAINTAINER Cloud Posse, LLC <hello@cloudposse.com>

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="WP-CLI build with Composer on top of Alpine Linux" \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.vcs-url="https://github.com/cloudposse/wp-cli.git" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.license="APACHE2"

# https://github.com/wp-cli/wp-cli/releases
ENV WP_CLI_VERSION 2.1.0

RUN (echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories) && \
    apk update && \
    apk upgrade && \
    apk add \
      ca-certificates \
      bash \
      curl \
      less \
      git \
      zip \
      freetype-dev \
      libjpeg-turbo-dev \
      libpng-dev \
      mariadb-client \
      mysql-client \
      php7 \
      php7-curl \
      php7-dom \
      php7-json \
      php7-openssl \
      php7-iconv \
      php7-mbstring \
      php7-phar \
      php7-zip \
      php7-zlib \
      php7-pdo \
      php7-dom \
      php7-gd \
      php7-mysqli && \
  rm -rf /var/cache/apk/*

## Install composer
RUN (curl --fail -sS https://getcomposer.org/installer | php) && \
    chmod +x composer.phar && \
    mv composer.phar /usr/bin/composer && \
    composer -V

## Install wp-cli
RUN composer create-project wp-cli/wp-cli:$WP_CLI_VERSION /usr/share/wp-cli --no-dev && \
    ln -sf /usr/share/wp-cli/bin/wp /usr/bin/wp && \
    ln -sf /usr/share/wp-cli/bin/wp /usr/bin/wp-cli && \
    wp cli version

ENTRYPOINT ["/usr/bin/wp", "--allow-root", "--path=/mnt"]
