#!/bin/bash

#Variables
project=$1
daysAgo=$2
cummulative=$3
s3Folder=$4
isCummulative=yes


# Needs to pass a matching string
if [[ -z $project ]] || [[ -z $daysAgo ]] || [[ -z $cummulative ]] || [[ -z $s3Folder ]];
then
  echo "Project, days ago, cummulative flag or s3Folder info missing. Exiting"
  exit 0
fi


if [[ "$cummulative" == "$isCummulative" ]];
then

   while [ "$daysAgo" -ge 1 ]
   do
      /home/streamsets/marsdb/scripts/python_shell_scripts/S3StorageProcess.sh $project $daysAgo $s3Folder >> /home/streamsets/marsdb/S3ProcessResult.txt
      daysAgo=`expr $daysAgo - 1`
   done

   exit 0
fi

# Single execution for the specific day in the past
/home/streamsets/marsdb/scripts/python_shell_scripts/S3StorageProcess.sh $project $daysAgo $s3Folder >> /home/streamsets/marsdb/S3ProcessResult.txt