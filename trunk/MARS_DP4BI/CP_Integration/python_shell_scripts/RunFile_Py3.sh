#!/bin/bash

scriptDir="/home/streamsets/marsdb/scripts"
createdFilesDir="/home/streamsets/marsdb/tmp/new_tables/created/"
pendingFilesDir="/home/streamsets/marsdb/tmp/new_tables/pending/"
label=$1
var=0

# Check if pending or created directories have files in them. If they don't then exit.
if ls -1qA $createdFilesDir | grep -q .
then
	((var=var+1))
fi

if ls -1qA $pendingFilesDir | grep -q .
then
	((var=var+1))
fi

if [[ $var -eq 0 ]];
then
  # echo "No files to process. Exiting"
  exit 0
fi

scriptname=$(basename $0)
pidfile="/var/run/${scriptname}"

# echo $scriptname

# lock the process so only one instance will run. Other instances will wait in a queue to finish (changed the process to have a generic job)
#exec 200>$pidfile
#flock 200 || exit 1
#pid=$$
#echo $pid 1>&200

echo "Stopping jobs"
python3 /home/streamsets/marsdb/scripts/Streamsets_Control_Script.py --label $label --action 'STOP'
ret=$?
if [ $ret -eq 0 ]
then
  files=$(shopt -s nullglob dotglob; echo /home/streamsets/marsdb/tmp/new_tables/created/*)
  if ((${#files}))
  then
    # move files for LOAD pipelines
    mv -v /home/streamsets/marsdb/tmp/new_tables/created/* /home/streamsets/marsdb/tmp/stage/
  fi
  echo "Starting now"
  python3 /home/streamsets/marsdb/scripts/Streamsets_Control_Script.py --label $label --action 'START' --resetOrigin 'True'
  ret2=$?
  if [ $ret2 -eq 0 ]
  then
    exit 0
  else
    exit 1
  fi
else
  exit 1
fi
