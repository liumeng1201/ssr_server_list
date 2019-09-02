#!/bin/bash

WORK_DIR="/home/lm/ssr"

URL="https://raw.githubusercontent.com/nulastudio/Freedom/master/docs/index.html"

echo "=> Change work dir."
cd ${WORK_DIR}

OPT()
{
    line=$1
    line=${line##*'link="'}
    line=${line%%'">'*}
    echo $line >> ssr.txt
}

echo "=> "`date`". Start sync ssr server."

echo "" > ssr.txt
curl $URL -A "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36" | grep 'link="ssr://' | while read line; do OPT "$line"; done
echo "" >> ssr.txt

echo -n `cat ssr.txt` | base64 | sed s/[[:space:]]//g > ssr_base64.txt
cat ssr_base64.txt

echo "=> "`date`". End sync ssr server"

#--push to git--#
git add .
git commit -m 'update'
git push
