#!/bin/sh -l

set -x

composer install --prefer-dist

cp .env.example .env

php ./artisan key:generate

XDEBUG_MODE=coverage php vendor/bin/phpunit --coverage-text
