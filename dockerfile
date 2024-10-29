# Utilise la dernière image PHP avec Apache
FROM php:apache

# Installe les outils nécessaires et les extensions PHP
RUN apt-get update && apt-get install -y \
    locales \
    libicu-dev \
    libzip-dev \
    libyaml-dev \
    gettext \
    unzip \
    git \
    && docker-php-ext-configure intl \
    && pecl install yaml \
    && docker-php-ext-enable yaml \
    && docker-php-ext-install mysqli intl zip \
    && echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=fr_FR.UTF-8 LC_ALL=fr_FR.UTF-8 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Définir la locale par défaut
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8    

# Active le module Apache mod_rewrite
RUN a2enmod rewrite

# Configure Apache pour autoriser les fichiers .htaccess dans /public_html
COPY docker-vhost.conf /etc/apache2/sites-available/000-default.conf

# Installe Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copie les fichiers du projet
COPY . /var/www

# Exécute composer install en racine
WORKDIR /var/www
RUN composer install --prefer-dist --no-scripts --no-progress --no-suggest --no-interaction --no-dev

# Permissions pour Apache
RUN chown -R www-data:www-data /var/www
