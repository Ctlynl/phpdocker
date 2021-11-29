#!/bin/sh
# get all filename in specified path
# set crontab

path=$1
files=$(ls $path)
for filename in $files
do
   cat $filename >> /var/spool/cron/crontabs/root
done