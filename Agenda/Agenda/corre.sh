#!/bin/bash
cat agenda.txt >  /var/spool/cron/root
crond -s -P
echo "# Agenda ##############################################"
crontab -l
echo "#######################################################"
date > agenda.log
date > last.log
echo "#######################################################"
tail -f *.log
