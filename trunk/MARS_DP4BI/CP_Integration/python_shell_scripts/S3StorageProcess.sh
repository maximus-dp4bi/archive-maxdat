#!/bin/bash

sourceFilesDir="/home/streamsets/marsdb/processed/stage"
tmpFilesDir="/home/streamsets/marsdb/processed/s3"
stageDir="/home/streamsets/marsdb/processed/s3_stage"
project=$1
daysAgo=$2
#s3Folder="s3://com.maximus.dp4bi.product.dev/MARSDB/PROCESSED_FILES"
s3Folder=$3
var=0

# move marsdb folder (so find works without problems)
cd /home/streamsets/marsdb

# Needs to pass a matching string
if [[ -z $project ]] || [[ -z $daysAgo ]] || [[ -z $s3Folder ]];
then
  echo "Project, days ago, cummulative flag or s3Folder info missing. Exiting"
  exit 0
fi

# Retrieve the year, month, iniDate info
iniDate=`date --date="-$daysAgo day" +%Y%m%d`
year=`date --date="-$daysAgo day" +%Y`
month=`date --date="-$daysAgo day" +%m`

# Define fileMatch variable
fileMatch="${project}-${iniDate}"

# Creates the project directory if it doesn't exists
mkdir -p $tmpFilesDir/$project
chown sdc:sdc $tmpFilesDir/$project

#mv the files that matches the string in the sourceFilesDir folder to the tmpFilesDir folder
find $sourceFilesDir -name *$fileMatch* -exec mv {} $tmpFilesDir/$project/ \;

# Check if there are files in tmpFilesDir folder
if ls -1qA $tmpFilesDir | grep -q .
then
        ((var=var+1))
fi

if [[ $var -eq 0 ]];
then
  echo "${fileMatch}: No files to process. Exiting"
  exit 0
fi

# tar.gz files to be pushed to S3 bucket
tarFileName="marsdb-cdc-${fileMatch}.tar.gz"
tarFullFileName="${stageDir}/${tarFileName}"
tmpFiles="${tmpFilesDir}/*${fileMatch}*"
tar -czf $tarFullFileName -C $tmpFilesDir/$project .

#Get the date part to create S3 structure (not used since we can get yeaer and month from teh date now. Kept for reference)
#IFS='-' read -ra array <<< "$fileMatch"
#year=${array[1]:0:4}
#month=${array[1]:4:2}

# Copy file to AWS folder
/usr/local/bin/aws s3 cp $tarFullFileName  $s3Folder/$year/$month/$tarFileName &> /dev/null

# Remove files from tmpFilesDir folder
rm -rf $tmpFilesDir/$project/*$fileMatch*

echo "${fileMatch}: Matching files processed"
