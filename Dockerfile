FROM debian:bookworm-slim

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install --no-install-suggests -y ca-certificates php8.1 php8.1-fpm php8.1-common \
    php8.1-mysql php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl php8.1-sqlite3 \
    php8.1-bcmath php8.1-xml php8.1-intl php8.1-tidy php-common php-imagick imagemagick composer

RUN echo "[www]" > /etc/php/8.1/fpm/pool.d/www.conf \
    && echo "user = www-data" >> /etc/php/8.1/fpm/pool.d/www.conf \
    && echo "group = www-data" >> /etc/php/8.1/fpm/pool.d/www.conf \
    && echo "listen = 0.0.0.0:9000" >> /etc/php/8.1/fpm/pool.d/www.conf \
    && echo "listen.owner = www-data" >> /etc/php/8.1/fpm/pool.d/www.conf \
    && echo "listen.group = www-data" >> /etc/php/8.1/fpm/pool.d/www.conf \
    && echo "pm = dynamic" >> /etc/php/8.1/fpm/pool.d/www.conf \
    && echo "pm.max_children = 5" >> /etc/php/8.1/fpm/pool.d/www.conf \
    && echo "pm.start_servers = 2" >> /etc/php/8.1/fpm/pool.d/www.conf \
    && echo "pm.min_spare_servers = 1" >> /etc/php/8.1/fpm/pool.d/www.conf \
    && echo "pm.max_spare_servers = 3" >> /etc/php/8.1/fpm/pool.d/www.conf

RUN echo "daemonize = no" > /etc/php/8.1/fpm/php-fpm.conf \
    && echo "include=/etc/php/8.1/fpm/pool.d/*.conf" >> /etc/php/8.1/fpm/php-fpm.conf
RUN echo "max_execution_time = 200" >> /etc/php/8.1/fpm/php.ini \
    && echo "post_max_size = 100M" >> /etc/php/8.1/fpm/php.ini \
    && echo "upload_max_filesize = 20M" >> /etc/php/8.1/fpm/php.ini \
    && echo "memory_limit = 256M" >> /etc/php/8.1/fpm/php.ini

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
CMD ["php-fpm8.1"]
