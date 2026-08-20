FROM nextcloud:34-apache

RUN apt update \
  && apt install -y wget gnupg2 unzip smbclient libsmbclient-dev ocrmypdf tesseract-ocr-eng tesseract-ocr-fra libbz2-dev && rm -rf /var/lib/apt/lists/* && pecl install smbclient && docker-php-ext-enable smbclient && docker-php-ext-install bz2

# Increase memory limits
RUN echo memory_limit=1024M > /usr/local/etc/php/conf.d/memory-limit.ini
