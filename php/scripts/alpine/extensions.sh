#!/bin/bash
apk add --update --no-cache \
    php7@php \
    php7-apcu@php	\
    php7-bcmath@php \
    php7-bz2@php \
    php7-calendar@php \
    php7-common@php \
    php7-ctype@php \
    php7-curl@php \
    php7-dba@php \
    php7-dev@php \
    php7-dom@php \
    php7-embed@php \
    php7-enchant@php \
    php7-exif@php \
    php7-fpm@php \
    php7-ftp@php \
    php7-gd@php \
    php7-gettext@php \
    php7-gmp@php \
    php7-iconv@php \
    php7-imagick@php \
    php7-imap@php \
    php7-intl@php \
    php7-json@php \
    php7-ldap@php \
    php7-libsodium@php \
    php7-litespeed@php \
    php7-mbstring@php \
    php7-mcrypt@php \
    php7-memcached@php \
    php7-tokenizer@php \
    php7-mongodb@php \
    php7-mysqli@php \
    php7-mysqlnd@php \
    php7-odbc@php \
    php7-opcache@php \
    php7-openssl@php \
    php7-pcntl@php \
    php7-pdo_dblib@php \
    php7-pdo_mysql@php \
    php7-pdo_pgsql@php \
    php7-pdo_sqlite@php \
    php7-pdo@php \
    php7-pear@php \
    php7-pgsql@php \
    php7-phar@php \
    php7-phpdbg@php \
    php7-posix@php \
    php7-pspell@php \
    php7-redis@php \
    php7-session@php \
    php7-shmop@php \
    php7-snmp@php \
    php7-soap@php \
    php7-sockets@php \
    php7-sqlite3@php \
    php7-sysvmsg@php \
    php7-sysvsem@php \
    php7-sysvshm@php \
    php7-tidy@php \
    php7-wddx@php \
    php7-xdebug@php \
    php7-xml@php \
    php7-xmlreader@php \
    php7-xmlrpc@php \
    php7-xsl@php \
    php7-zip@php \
    php7-zlib@php

ln -s /usr/bin/php7 /usr/bin/php
ln -s /usr/bin/phpize7 /usr/bin/phpize
ln -s /usr/bin/php-fpm7 /usr/bin/php-fpm
