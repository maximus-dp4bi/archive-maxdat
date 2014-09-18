#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR

. $BASEDIR/set_env_vars.sh

#this script will call the one-time agent turnover kjb

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/implementation/ILEB/jobs/one-time
JOB=one_time_load_update_agents
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="JeromeHampson@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo $LOG_DIR
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
