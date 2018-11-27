FROM newdeveloper/apache-php-composer

# install git
RUN apt-get update
RUN apt-get install -y git
RUN apt-get clean

# clone polr
WORKDIR /var/www
RUN git clone https://github.com/cydrobolt/polr.git --depth=1
RUN chmod -R 755 polr
RUN chown -R www-data polr

# download composer package & update/install dependencies
WORKDIR /var/www/polr
RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar install --no-dev -o

# rename .env.setup
WORKDIR /var/www/polr
RUN cp .env.setup .env
RUN chown -R www-data .

# change document root
ENV APACHE_DOCUMENT_ROOT /var/www/polr/public
COPY polr.conf /etc/apache2/sites-available/000-default.conf