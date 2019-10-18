#!/bin/bash

docker image build -f Dockerfile -t cardonaje/nextcloud:17.0.0-fpm  /srv/nextcloud-builder --pull
docker push cardonaje/nextcloud:17.0.0-fpm

