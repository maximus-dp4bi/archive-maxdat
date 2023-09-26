#!/bin/sh
#export VISUAL=vi
MAXDAT_ETL_PATH=/dtxe4t/ETL_Scripts/scripts
MAXDAT_ETL_LOGS=/dtxe4t/ETL_Logs/logs
MAXDAT_KETTLE_DIR=/dtxe4t/3rdparty/app/product/kettle/4.2/data-integration
STCODE=TX
export MAXDAT_ETL_PATH
export MAXDAT_ETL_LOGS
export MAXDAT_KETTLE_DIR
export STCODE
PATH=$MAXDAT_KETTLE_DIR:/usr/bin::/usr/X11/lib:/usr/X11/bin/:/usr/local/bin:/usr/local/git/bin:/usr/local/sbin:/dtxe4t/3rdparty:/usr/X/bin
export PATH;
#added the parameter as part of JIRA-2787
MAXDAT_MOTS_FILES=/dtxe4t/3rdparty/mots/files
export MAXDAT_MOTS_FILES
## jira 8045
AO_ROOT=/dtxe4t/ETL_Scripts/scripts/AO
AO_ETL_PATH=/dtxe4t/ETL_Scripts/scripts/AO/main
AO_ETL_LOGS=/dtxe4t/ETL_Logs/logs/AO
AO_FILES_DIR=/dtxe4t/3rdparty/AO/files

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
#START_DATE=$(date +%Y%m16 --date='last month')
START_DATE=$(perl -MPOSIX=strftime -le '@t = localtime; $t[3] = 1; $t[4]--; print strftime("%Y%m16", @t)')
END_DATE=$(date +%Y%m15 --date='today')

ksh $AO_ETL_PATH/bin/run_project_ao_input_job_tx.sh TXEC $START_DATE $END_DATE $JOB $JOBTYPE
sleep 10
