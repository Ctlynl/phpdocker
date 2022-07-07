#!/bin/sh
# get all filename in specified path
# set crontab

path=$1
cd $path
crontabPath=/var/spool/cron/crontabs/root
files=$(ls $path)
for filename in $files
do
   cat $filename >> ${crontabPath}
done
# delete empty row
sed -i '/^$/d' ${crontabPath}