#!/bin/sh -l

set -x

curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
apk add --no-cache unzip
apk add --no-cache --virtual .build-deps autoconf g++ make && pecl install redis && apk del .build-deps
docker-php-ext-configure pcntl --enable-pcntl && docker-php-ext-install pcntl pdo pdo_mysql && docker-php-ext-enable redis && rm -rf /tmp/pear

composer install --prefer-dist
cp .env.example .env

pwd
ls -la
php ./artisan key:generate

php vendor/bin/phpunit
