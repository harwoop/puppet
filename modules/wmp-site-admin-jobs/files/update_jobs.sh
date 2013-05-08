#!/bin/bash

URL="http://localhost/tools/required/jobs?auth=5de4e738ecc1fe2bf2ba5120d45c956d&jID="
JOBS="14 10 13 8 12 11 9 1 2 18 22"
LOG="/data/logs/httpd/wmp/admin_jobs.log"
FILESDIR="/data/httpd/wmp/files/"

echo "---- `date` ----" >> $LOG
for j in $JOBS
do
  echo "$URL$j" >> $LOG
  /usr/bin/curl -sS $URL$j >> $LOG
  echo >> $LOG
done

find $FILESDIR -name 'index.html' -delete && find $FILESDIR -type d -empty -delete

