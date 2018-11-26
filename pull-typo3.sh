#!/usr/bin/env bash

read -r -d '' TYPO3INSTALL << EOM
php /app/vendor/bin/typo3cms install:setup \
    --no-interaction \
    --database-host-name=global-database \
    --database-port=3306 \
    --database-user-name=root \
    --database-user-password=root \
    --database-name=typo3demo \
    --admin-user-name=admin \
    --admin-password=Admin123 \
    --site-setup-type=site
EOM

rm -rf .git && \
touch .env && \
docker-compose up -d && \
docker-compose exec web bash -c 'mkdir /tmp/typo3cms && composer create-project typo3/cms-base-distribution /tmp/typo3cms ^9 && rsync -av /tmp/typo3cms/ /app/ && rm -rf /tmp/typo3cms' && \
docker-compose exec web bash -c "${TYPO3INSTALL}"
