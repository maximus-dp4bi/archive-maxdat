#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR

. $BASEDIR/set_env_vars.sh

# This program will run the Kettle job that initializes MAXDAT Contact Center during install

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

#echo TZ=$TZ+24 date +.%Y/%m/%d

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs/initialization
JOB=initialize_Contact_Center
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="ClayRowland@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo $LOG_DIR
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" $PARAMS -level="$DETAIL_LOG_LEVEL" >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"