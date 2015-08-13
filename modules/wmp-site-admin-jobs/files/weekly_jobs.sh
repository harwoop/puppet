#!/bin/bash
URL="http://admin2.aws.cambridge.org/tools/required/jobs?mode=weekly&auth=5de4e738ecc1fe2bf2ba5120d45c956d&jID="
JOBS="146 149 152"
LOG="/data/logs/httpd/wmp/admin_jobs.log"
echo "---- `date` ----" >> $LOG
for j in $JOBS
do
  echo "$URL$j" >> $LOG
  /usr/bin/curl -sS $URL$j >> $LOG
  echo >> $LOG
done

