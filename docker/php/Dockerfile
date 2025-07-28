FROM php:8.3-fpm

ARG UID=1000
ARG GID=1000

# System packages
RUN apt-get update && apt-get install -y \
    procps \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    zip unzip curl git libzip-dev libpq-dev libicu-dev \
    imagemagick ghostscript libmagickwand-dev \
    supervisor cron \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl intl \
    && pecl install redis imagick \
    && docker-php-ext-enable redis imagick

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

RUN apt-get update && apt-get install -y libxml2-dev \
    && docker-php-ext-install soap

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN groupmod -g ${GID} www-data && usermod -u ${UID} -g ${GID} www-data

WORKDIR /var/www

RUN mkdir -p /etc/supervisor/config

COPY ./src ./
COPY ./docker/php/php.ini /usr/local/etc/php/conf.d/custom.ini
COPY ./docker/supervisor/config/*.conf /etc/supervisor/config/
COPY ./docker/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY --chmod=755 ./docker/entrypoint.sh /entrypoint.sh

# RUN composer install --no-interaction --prefer-dist --optimize-autoloader

RUN mkdir -p /var/www/storage/logs/supervisor /var/log/supervisor && \
    chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache /var/log/supervisor /var/log

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]