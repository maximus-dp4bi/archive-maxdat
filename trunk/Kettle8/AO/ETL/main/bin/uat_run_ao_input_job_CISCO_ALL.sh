#!/bin/bash
#. ~/.bash_profile

location='/u01/maximus/maxdat-uat/AO8/ETL/main/bin'
source ${location}/.set_env

PROGNAME=$(basename $0 .sh)

BASEDIR=$(dirname $0)
echo $BASEDIR

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$AO_ETL_PATH/jobs
JOB=manage_agent_input_extracts
JOBTYPE=Input
echo $AO_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"
START_DATE=$(date +%Y%m16 --date='last month')
END_DATE=$(date +%Y%m15 --date='today')

sh $AO_ETL_PATH/bin/run_project_ao_input_job_ALL.sh CISCO_ALL 20170801 20180201 $JOB $JOBTYPE
sleep 10

