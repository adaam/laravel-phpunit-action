FROM php:8.0-alpine

LABEL "com.github.actions.name"="Laravel PHPUnit"
LABEL "com.github.actions.description"="A GitHub action to run your Laravel project's PHPUnit test suite."
LABEL "com.github.actions.icon"="check-circle"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="https://github.com/nathanheffley/laravel-phpunit-action"
LABEL "homepage"="https://github.com/nathanheffley/laravel-phpunit-action"
LABEL "maintainer"="Nathan Heffley <nathan@nathanheffley.com>"

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN apk add --no-cache unzip && apk add --update linux-headers
RUN apk add --no-cache --virtual .build-deps autoconf g++ make && pecl install redis xdebug && apk del .build-deps
RUN docker-php-ext-configure pcntl --enable-pcntl && docker-php-ext-install pcntl pdo pdo_mysql && docker-php-ext-enable redis && docker-php-ext-enable xdebug && rm -rf /tmp/pear

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
