FROM nextcloud:23-apache

RUN apt update \
  && apt install -y wget gnupg2 unzip smbclient libsmbclient-dev ocrmypdf tesseract-ocr-eng tesseract-ocr-fra libbz2-dev libopenblas-base && rm -rf /var/lib/apt/lists/* && pecl install smbclient && docker-php-ext-enable smbclient && docker-php-ext-install bz2 

# Enable repo and install dlib
RUN echo "deb https://repo.delellis.com.ar bullseye bullseye" > /etc/apt/sources.list.d/20-pdlib.list \
  && wget -qO - https://repo.delellis.com.ar/repo.gpg.key | apt-key add -
RUN apt update \
  && apt install -y libdlib-dev

# Install pdlib extension
RUN wget https://github.com/goodspb/pdlib/archive/master.zip \
  && mkdir -p /usr/src/php/ext/ \
  && unzip -d /usr/src/php/ext/ master.zip \
  && rm master.zip
RUN docker-php-ext-install pdlib-master

# Increase memory limits
RUN echo memory_limit=1024M > /usr/local/etc/php/conf.d/memory-limit.ini

# These last lines are just for testing the extension.. You can delete them.
RUN wget https://github.com/matiasdelellis/pdlib-min-test-suite/archive/master.zip \
  && unzip -d /tmp/ master.zip \
  && rm master.zip
RUN cd /tmp/pdlib-min-test-suite-master \
    && make
