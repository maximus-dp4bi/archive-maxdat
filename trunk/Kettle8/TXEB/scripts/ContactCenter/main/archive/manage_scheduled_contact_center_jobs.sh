#!/bin/bash
. ~/.profile

# tx_run_cc.sh
# This program will run the Kettle job necessary to initialize the Contact Center data mart

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

#echo TZ=$TZ+24 date +.%Y/%m/%d

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs
JOB=manage_all_scheduled_jobs
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

#START/END DATETIME PARAM CMD LINE OPTS
#--------------------------------------
#YESTERDAY="2013-03-04 00:00:00"
#TODAY="2013/03/05 00:00:00"
#YESTERDAY=$(date -d '1 day ago' +'%Y-%m-%d %T')
#TODAY=$(date +'%Y-%m-%d %T') 
#START=$(date -d '2 hours ago' +'%Y-%m-%d %T')
#END=$(date +'%Y-%m-%d %T')

#PARAMS="-param:startDateTimeParam=$YESTERDAY -param:endDateTimeParam=$TODAY"

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="ClayRowland@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo $LOG_DIR
LOG_LEVEL="Detailed"

ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
#-param:startDateTimeParam="$START" -param:endDateTimeParam="$END" 