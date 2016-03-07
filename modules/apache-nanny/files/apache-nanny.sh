#!/bin/bash

# Nanny script to restart Apache if it reaches 250 child processes
# (for v2) or if a curl returns a non-200 response

emaillog="/app/scripts/apache-nanny-email.log"
auditlog="/app/scripts/apache-nanny-audit.log"
host=`hostname`
numprocs=`ps -ef | grep httpd | grep -v grep | wc -l`
datetime=`date +"%H:%M:%S %d/%m/%y"`
devs="rvillamor@cambridge.org,ergercayo@cambridge.org,jyu@cambridge.org,cdeocampo@cambridge.org,pvillareal@cambridge.org,sflores@cambridge.org"

# recreate the email log file
if [ -e $emaillog ]; then rm $emaillog; fi
touch $emaillog

# main script logic
printf "Executing apache-nanny.sh at ${datetime}\n\n" >> $emaillog
printf "\nExecuting apache-nanny.sh at ${datetime}: " >> $auditlog
printf "The number of httpd processes is: ${numprocs}\n\n" >> $emaillog
printf "The number of httpd processes is: ${numprocs}: " >> $auditlog

if [ "$numprocs" -gt 250 ]
then
        printf "Apache processes over the 250 limit on ${host}\n\n" >> $emaillog
        printf "Restarting Apache to keep the WMP ship afloat\n\n" >> $emaillog
        printf "Restarting Apache to keep the WMP ship afloat: " >> $auditlog
        service httpd restart
        if [ "$?" -ne 0 ]
        then
                /usr/bin/pkill -9 httpd
                if [ "$?" -ne 0 ]
                then
                        printf "Failed to kill the httpd processes with the pkill command - please manually intervene!\n\n" >> $emaillog
                        printf "Failed to kill the httpd processes, even with the pkill command" >> $auditlog
                        mailx -s "apache-nanny.sh struggled to restart Apache on ${host}" ghs@cambridge.org,gie@cambridge.org,$devs < $emaillog

                else
                        service httpd start
                        prinf "Had to stop Apache using pkill command, then restarted Apache\n\n" >> $emaillog
                        prinf "Had to stop Apache using pkill command, then restarted Apache" >> $auditlog
                        mailx -s "apache-nanny.sh restarted Apache after killing it using pkill on ${host}" ghs@cambridge.org,gie@cambridge.org,$devs < $emaillog
                fi
        else
                mailx -s "apache-nanny.sh restarted Apache on ${host}" ghs@cambridge.org,gie@cambridge.org,$devs < $emaillog
        fi
else
        printf "Don't panic - all is well\n\n" >> $emaillog
        printf "Don't panic - all is well" >> $auditlog
fi

