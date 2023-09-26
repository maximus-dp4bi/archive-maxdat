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
TO_DATE==$(date +%Y%m%d --date='today')

sh $AO_ETL_PATH/bin/run_project_ao_input_job.sh TXEC 20161001 20170315 $JOB $JOBTYPE
mv /u01/maximus/maxdat-dev/AO/files/Agentmap/Outbound/$(date +%Y%m%d --date='today')_TXEC_AO_AgentACD_Input_Data_File.csv /u01/maximus/maxdat-dev/AO/files/Agentmap/Outbound/$(date +%Y%m%d --date='today')_TXEC_AO_AgentACD_Input_Data_File_20161001_20170315.csv
sleep 10

