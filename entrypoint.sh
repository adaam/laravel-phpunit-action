#!/bin/sh -l

curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
composer install --prefer-dist

cp .env.example .env

php artisan key:generate

php vendor/bin/phpunit
