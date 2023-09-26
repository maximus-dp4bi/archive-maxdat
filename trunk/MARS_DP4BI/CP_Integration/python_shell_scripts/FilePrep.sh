#!/bin/bash

scriptDir="/home/streamsets/marsdb/scripts"
#CDCDir="/home/streamsets/marsdb/tmp/cdc/"
CDCDir="/home/streamsets/"$1

echo "Deleting empty folders"
find $CDCDir -mindepth 1 -mtime +2 -type d -empty -delete

echo "Touching skipped files if any"
find $CDCDir -mindepth 1 -name marsdb-* -exec touch {} + 

