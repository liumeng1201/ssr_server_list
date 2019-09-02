#!/bin/bash

WORK_DIR="/home/lm/ssr"
SSR_FILE=`echo $WORK_DIR"/ssr.txt"`
TMP=`echo $WORK_DIR"/tmp"`
SSR_BASE64_FILE=`echo $WORK_DIR"/ssr_base64.txt"`

URL="https://raw.githubusercontent.com/nulastudio/Freedom/master/docs/index.html"

echo "=> Change work dir."
cd ${WORK_DIR}

OPT()
{
    line=$1
    line=${line##*'link="'}
    line=${line%%'">'*}
    echo $line >> ${SSR_FILE}
}

echo "=> "`date`". Start sync ssr server."

echo "" > ${SSR_FILE}
curl $URL -A "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36" | grep 'link="ssr://' | while read line; do OPT "$line"; done
echo "" >> ${SSR_FILE}

echo -n `cat ${SSR_FILE}` | base64 > ${TMP}
echo -n `cat ${TMP}` | sed s/[[:space:]]//g > ${SSR_BASE64_FILE}

echo "=> "`date`". End sync ssr server"

#--push to git--#
git add .
git commit -m 'update'
git push
