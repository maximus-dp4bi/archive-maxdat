#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR

#. $BASEDIR/set_env_vars.sh
#. /u01/maximus/maxdat-dev/CALL8/scripts/main/bin/.set_env
. $BASEDIR/.set_env

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$MAXDAT_ETL_PATH/main/jobs
JOB=load_CALL_Provider_Transfers
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
STCODE=${STCODE^}
ENV_CODE=${ENV_CODE^^}
EMAIL="18956@maximus.com"
EMAIL_MESSAGE="$JOBS_DIR/$(basename $0)_ERROR_LOG"
EMAIL_SUBJECT="$STCODE $ENV_CODE - Errors with $STCODE_$(basename $0)"

LOG_DIR=$MAXDAT_ETL_LOGS
echo $LOG_DIR
LOG_LEVEL="Detailed"

##sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" $PARAMS -level="$DETAIL_LOG_LEVEL" >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
rc=$?
if [[ $rc != 0 ]] ; then
	echo "Exited with status: $rc - $(basename $0), aborting run in $STCODE $ENV_CODE"  > $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
fi
