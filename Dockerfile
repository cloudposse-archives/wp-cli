FROM alpine:latest

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
ENV WP_CLI_VERSION 1.1.0

RUN apk add --update --repository http://dl-4.alpinelinux.org/alpine/v3.2/main --repository http://dl-4.alpinelinux.org/alpine/edge/testing \
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
      php \
      php-cli \
      php-curl \
      php-dom \
      php-json \
      php-mysql \
      php-openssl \
      php-phar \
      php-gd \
      php-mysqli && \
  rm -rf /tmp/src && \
  rm -rf /var/cache/apk/*

## Install composer
RUN (curl --fail -sS https://getcomposer.org/installer | php) && \
    chmod +x composer.phar && \
    mv composer.phar /usr/bin/composer && \
    composer -V

RUN composer create-project wp-cli/wp-cli:$WP_CLI_VERSION /usr/share/wp-cli --no-dev && \
	ln -s /usr/share/wp-cli/bin/wp /usr/bin/wp && \
	ln -s /usr/share/wp-cli/bin/wp /usr/bin/wp-cli


ENTRYPOINT ["/usr/bin/wp", "--allow-root", "--path=/mnt"]
