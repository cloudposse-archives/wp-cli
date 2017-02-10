# WP-CLI on Alpine Linux

WP-CLI built from Composer build on top of Alpine Linux.

## Usage

Below are you can find some example ways the image can be used.

### Bash alias
You can create a `bash` alias i.e.:
```
function wp() {
    docker run -it --rm \
        -v $(pwd):/mnt \
        cloudposse/wp-cli:latest ${@:1}
}
```

### Create a wordpress project
```
$ mkdir wp-test && cd wp-test
$ wp core download
$ wp core config --dbhost=db --dbname=wptest --dbuser=root --dbpass=root
$ wp core install \
    --url=http://wp-test \
    --title="Awesome website" \
    --admin_user=admin --admin_password=admin --admin_email admin@admin.com
```

### Database operations
Import/export database:
```
$ cd /path/to/wordpress/project
$ wp db import /mnt/dump.sql
```
Since the `--path` point inside the container, your dump must be available inside.


## Credits

This image is built from bits and pieces of other Dockerfiles. Thanks to contributions by the following people:
- @mbodenhamer, https://github.com/mbodenhamer/docker-alpine-wpcli/
- @soifou, https://github.com/soifou/wpcli-alpine
