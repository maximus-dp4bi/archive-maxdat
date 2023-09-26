#!/bin/bash
. ~/.bash_profile
PROGNAME=$(basename $0 .sh)

BASEDIR=$(dirname $0)
echo $BASEDIR

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$AO_ETL_PATH/jobs
JOB=manage_all_acd_extracts
JOBTYPE=Extract
echo $AO_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

sh $AO_ETL_PATH/bin/run_project_ao_extract_job.sh MDHIX 20161116 20170115 $JOB $JOBTYPE

