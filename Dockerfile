# PHP image
FROM php:8.0-apache

# Install systme libraries
RUN apt-get update -y && apt-get install -y \
    build-essential \
    libpng-dev \
    zlib1g-dev \
    libicu-dev \
    libzip-dev

# Install docker dependencies
RUN apt-get install -y libc-client-dev libkrb5-dev \
    && docker-php-ext-configure gd \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-ext-install intl \
    && docker-php-source delete

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Download composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Define working directory
WORKDIR /home/app

# Copy project
COPY . /home/app

# Run composer install
RUN composer install --ignore-platform-reqs

# Expose the port
EXPOSE 8080

# Run server
CMD php artisan serve --host=0.0.0.0 --port=8080
