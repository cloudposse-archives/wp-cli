# WP-CLI on Alpine Linux

WP-CLI built from Composer build on top of Alpine Linux.

## Usage

Below are some examples of how you can use `wp-cli`.

### Bash alias

Create a `bash` alias i.e.:

```shell
function wp() {
    docker run -it --rm \
        -v $(pwd):/mnt \
        cloudposse/wp-cli:latest ${@:1}
}
```

### Create a Wordpress project

```shell
$ mkdir wp-test && cd wp-test
$ wp core download
$ wp core config --dbhost=db --dbname=wptest --dbuser=root --dbpass=root
$ wp core install \
    --url=http://wp-test \
    --title="Awesome website" \
    --admin_user=admin --admin_password=admin --admin_email admin@example.com
```

### Perform Database Operations

Import/export database:
```shell
$ cd /path/to/wordpress/project
$ wp db import /mnt/dump.sql
```

NOTE: The `--path` argument is relative to paths inside of the container. Bind mount volumes as necessary.


## Credits

This image is built from bits and pieces of other Dockerfiles. 

Thanks to contributions by the following people:
- @mbodenhamer, https://github.com/mbodenhamer/docker-alpine-wpcli/
- @soifou, https://github.com/soifou/wpcli-alpine
- @xtreamwayz, https://github.com/xtreamwayz/dckr-php
