#!/bin/bash

URL="http://localhost/tools/required/jobs?auth=5de4e738ecc1fe2bf2ba5120d45c956d&jID="
JOBS="73"
LOG="/data/logs/httpd/wmp/admin_jobs.log"

echo "---- `date` ----" >> $LOG
echo "---- Monthly Reports ----" >> $LOG
for j in $JOBS
do
  echo "$URL$j&since=''" >> $LOG
  /usr/bin/curl -sS $URL$j >> $LOG
  echo >> $LOG
done

