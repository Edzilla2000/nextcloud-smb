#!/bin/bash

docker image build -f Dockerfile -t cardonaje/nextcloud:16.0.5-fpm  /srv/nextcloud-builder --pull
docker push cardonaje/nextcloud:16.0.5-fpm

