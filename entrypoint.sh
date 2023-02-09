#!/bin/sh -l

set -x

cp .env.example .env

php ./artisan key:generate

php vendor/bin/phpunit --coverage-text
