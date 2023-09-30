#!/bin/bash
. ~/.bash_profile
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

sh $AO_ETL_PATH/bin/run_project_ao_input_job.sh MA_HEALTH 20170716 20180115 $JOB $JOBTYPE
sleep 10

#sh $AO_ETL_PATH/bin/run_project_ao_input_job.sh MA_HEALTH $START_DATE $END_DATE $JOB $JOBTYPE
sleep 10

sh $AO_ETL_PATH/bin/run_project_ao_input_job.sh FOLSOM $START_DATE $END_DATE $JOB $JOBTYPE
sleep 10

sh $AO_ETL_PATH/bin/run_project_ao_input_job.sh GLENDALE $START_DATE $END_DATE $JOB $JOBTYPE
sleep 10

sh $AO_ETL_PATH/bin/run_project_ao_input_job.sh FLHK $START_DATE $END_DATE $JOB $JOBTYPE
sleep 10

sh $AO_ETL_PATH/bin/run_project_ao_input_job.sh FHCO $START_DATE $END_DATE $JOB $JOBTYPE
sleep 10

sh $AO_ETL_PATH/bin/run_project_ao_input_job.sh RHCO $START_DATE $END_DATE $JOB $JOBTYPE
sleep 10

sh $AO_ETL_PATH/bin/run_project_ao_input_job.sh MDHIX $START_DATE $END_DATE $JOB $JOBTYPE
sleep 10

sh $AO_ETL_PATH/bin/run_project_ao_input_job.sh MIEB $START_DATE $END_DATE $JOB $JOBTYPE
sleep 10
