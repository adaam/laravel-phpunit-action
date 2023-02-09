#!/bin/sh -l

set -x

curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
apk add --no-cache unzip
apk add --no-cache --virtual .build-deps autoconf g++ make && pecl install redis xdebug && pecl list-files xdebug && apk del .build-deps
docker-php-ext-configure pcntl --enable-pcntl && docker-php-ext-install pcntl pdo pdo_mysql && docker-php-ext-enable redis && rm -rf /tmp/pear

composer install --prefer-dist
cp .env.example .env
echo -e "extension=xdebug.so\nzend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20200930/xdebug.so" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

pwd
ls -la
ls -la /usr/local/etc/php/conf.d/
php ./artisan key:generate

php vendor/bin/phpunit --coverage-text
