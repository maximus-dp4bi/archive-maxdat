#!/bin/bash
. ~/.profile
# run_flatten_contact_center.sh
# This program will run the Kettle job to flatten the Contact Center data mart to .csv files

STARTDATE=$1
ENDDATE=$2

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs/dimensional
JOB=flatten_MAXDAT_tables
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="JeromeHampson@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
LOG_LEVEL="Detailed"

ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL" -param:startDate=$STARTDATE -param:endDate=$ENDDATE >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

#kitchen status codes
# 0     The job ran without a problem.
# 1     Errors occurred during processing
# 2     An unexpected error occurred during loading or running of the job
# 7     The job couldn't be loaded from XML or the Repository
# 8     Error loading steps or plugins (error in loading one of the plugins mostly)
# 9     Command line usage printing
