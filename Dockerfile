FROM php:7.2-cli
# FROM php:7.1
# FROM php:latest
LABEL maintainer="akempler@gmail.com"

# ENTRYPOINT ["/root/entrypoint.sh"]

RUN rm /bin/sh \
 && ln -s /bin/bash /bin/sh

RUN apt-get update \
 && apt-get install -y \
 	libpng-dev \
  libjpeg-dev \
  libpq-dev \
  libxml2-dev \
  build-essential \
  mysql-client \
  git \
  curl \
  wget \
  vim \
  zip \
  libssh2-1-dev \
  php-ssh2 \
  openssh-server \
 && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
 && docker-php-ext-install gd mbstring opcache pdo pdo_mysql pdo_pgsql zip \
 && apt-get clean


 # Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer


# Install Drush
RUN composer global require drush/drush \
 && composer global update \
 && ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush

# Install Drupal Console
RUN composer require drupal/console:~1.0 --prefer-dist --optimize-autoloader
RUN composer update drupal/console --with-dependencies

#RUN composer global require "squizlabs/php_codesniffer=*"

RUN apt-get install -y \
 nodejs \
 npm

# Otherwise npm isntall will give an error about node.
RUN ln -s /usr/bin/nodejs /usr/bin/node


# Install nvm and update node to 6.0
#RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash

#RUN source ~/.bashrc \
# && nvm install 6.0


RUN npm install -g npm
# Disabled because initially during upgrade, the theme won't be there.
# RUN npm install

# Install gulp globally.
RUN npm install -g gulp-cli

# Copy configs
ADD conf/php.ini $PHP_INI_DIR/conf.d/

WORKDIR /var/www/html

# ADD entrypoint.sh /root
# RUN chmod +x /root/entrypoint.sh
