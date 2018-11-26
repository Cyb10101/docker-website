#!/usr/bin/env bash

rm -rf .git && \
git init && \
git remote add origin git@github.com:Cyb10101/test-website.git && \
git fetch && \
git reset origin/master && \
git checkout origin/master -- . && \
cp .env-dist .env && \
docker-compose up -d && \
docker-compose exec web bash -c 'composer install -d /app'
