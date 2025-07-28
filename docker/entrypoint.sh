#!/bin/bash

set -e

echo "Starting entrypoint..."

mkdir -p /var/www/storage/logs

touch \
  /var/www/storage/logs/php-fpm.log \
  /var/www/storage/logs/php-fpm.err.log \
  /var/www/storage/logs/horizon.log \
  /var/www/storage/logs/horizon.err.log \
  /var/www/storage/logs/scheduler.log \
  /var/www/storage/logs/scheduler.err.log

chown -R www-data:www-data /var/www/storage/logs
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
chmod -R ug+rw /var/www/storage /var/www/bootstrap/cache

exec "$@"