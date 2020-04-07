#!/bin/bash

WORK_DIR="/home/lm/ssr"
SSR_FILE=`echo $WORK_DIR"/ssr.txt"`

URL="https://www.liesauer.net/yogurt/subscribe?ACCESS_TOKEN=d309c6921bbd7d0d"

echo "=> Change work dir."
cd ${WORK_DIR}

echo "=> "`date`". Start sync ssr server."

echo "" > ${SSR_FILE}
curl $URL -A "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36" | base64 -d > ${SSR_FILE}

echo "=> "`date`". End sync ssr server"

#--push to git--#
git add .
git commit -m 'update'
git push
