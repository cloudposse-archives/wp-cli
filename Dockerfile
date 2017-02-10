FROM alpine:edge

MAINTAINER Cloud Posse, LLC <hello@cloudposse.com>

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="WP-CLI baked with Composer on top of Alpine Linux" \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.vcs-url="https://github.com/cloudposse/wp-cli.git" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.license="APACHE2"

ENV WP_CLI_VERSION 1.1.0

RUN apk add --no-cache --repository "http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
    bash \
    curl \
    less \
    freetype-dev libjpeg-turbo-dev libpng-dev \
    mariadb-client \
    php7-gd \
    php7-mysqli \
    php7-mongodb


FROM mbodenhamer/alpine:latest
MAINTAINER Matt Bodenhamer <mbodenhamer@mbodenhamer.com>

RUN apk add --no-cache \
      curl \
      git \
      mysql-client \
      nano \
      php-cli \
      php-curl \
      php-dom \
      php-json \
      php-mysql \
      php-openssl \
      php-phar \
      zip && \
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
