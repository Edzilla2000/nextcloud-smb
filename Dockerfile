FROM nextcloud:27-apache

RUN apt update \
  && apt install -y wget gnupg2 unzip smbclient libsmbclient-dev ocrmypdf tesseract-ocr-eng tesseract-ocr-fra libbz2-dev libopenblas-dev && rm -rf /var/lib/apt/lists/* && pecl install smbclient && docker-php-ext-enable smbclient && docker-php-ext-install bz2

# Enable repo and install dlib
RUN echo "deb https://repo.delellis.com.ar bullseye bullseye" > /etc/apt/sources.list.d/20-pdlib.list \
  && wget --no-check-certificate -qO - https://repo.delellis.com.ar/repo.gpg.key | apt-key add -
RUN apt update \
  && apt install -y libdlib-dev build-essential cmake git libx11-dev

RUN git clone https://github.com/davisking/dlib.git \
&& cd dlib/dlib \
&& mkdir build \
&& cd build \
&& cmake -DBUILD_SHARED_LIBS=ON .. \
&& make \
&& make install

# Install pdlib extension
RUN wget https://github.com/goodspb/pdlib/archive/master.zip \
  && mkdir -p /usr/src/php/ext/ \
  && unzip -d /usr/src/php/ext/ master.zip \
  && rm master.zip
RUN docker-php-ext-install pdlib-master

# Increase memory limits
RUN echo memory_limit=1024M > /usr/local/etc/php/conf.d/memory-limit.ini
