#!/bin/bash

docker image build -f Dockerfile -t cardonaje/nextcloud:20.0-fpm  /root/nextcloud-builder --pull
docker push cardonaje/nextcloud:20.0-fpm

