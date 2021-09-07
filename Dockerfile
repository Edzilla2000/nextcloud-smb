FROM nextcloud:21.0-fpm

LABEL version="21.0-fpm"
LABEL description="Build nextcloud image with smb support"

RUN apt-get update && apt-get install -y smbclient libsmbclient-dev ocrmypdf tesseract-ocr-eng tesseract-ocr-fra && rm -rf /var/lib/apt/lists/* && pecl install smbclient && docker-php-ext-enable smbclient

COPY --chown=root:root www.conf /usr/local/etc/php-fpm.d/www.conf
