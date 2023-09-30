#!/bin/bash
. ~/.profile

# tx_run_cc.sh
# This program will run the Kettle job necessary to manage scheduled loads of the Contact Center data mart

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

kitchen_status()
{
#kitchen status codes
kitchenStatusDefs[1]="Errors occurred during processing"
kitchenStatusDefs[2]="An unexpected error occurred during loading or running of the job"
kitchenStatusDefs[7]="The job couldn't be loaded from XML or the Repository"
kitchenStatusDefs[8]="Error loading steps or plugins (error in loading one of the plugins mostly)"
kitchenStatusDefs[9]="Command line usage printing"
kitchenStatusDefs[0]="Success"
echo ${kitchenStatusDefs[$1]}
}

function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------

	echo "see: $LOG_FILE for details."
	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs
JOB=manage_all_scheduled_jobs
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR


ERRORS_FOUND="/tmp/$STCODE_child_task_fail.txt"

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="ClayRowland@maximus.com"
EMAIL_MESSAGE="$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
EMAIL_SUBJECT="Errors Occurred Executing $JOB"

rm -f $EMAIL_MESSAGE

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
LOG_FILE="$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
echo $LOG_FILE
LOG_LEVEL="Detailed"
LOG_NAME=$JOB$(date +%Y%m%d_%H%M%S).log


ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> $LOG_FILE
kjbrc=$?
  if [[ $kjbrc != 0 ]]
  then
	  #failure
	  echo "$kjbrc ${1/\//}" >> $ERRORS_FOUND
	  echo "ERROR-CODE-$kjbrc IN $JOB, See $LOG_NAME for details." >> $EMAIL_MESSAGE
	  kitchen_status $kjbrc >> $EMAIL_MESSAGE
	  mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	  cat $EMAIL_MESSAGE
	  error_exit "$LINENO: An error has occurred in $JOB"
   else
	  #success
	  echo "$(date +%Y%m%d_%H%M%S) $JOB Completed Successfully"
	  kitchen_status $kjbrc
  fi
exit 0

#echo TZ=$TZ+24 date +.%Y/%m/%d

#START/END DATETIME PARAM CMD LINE OPTS
#--------------------------------------
#YESTERDAY="2013-03-04 00:00:00"
#TODAY="2013/03/05 00:00:00"
#YESTERDAY=$(date -d '1 day ago' +'%Y-%m-%d %T')
#TODAY=$(date +'%Y-%m-%d %T') 
#START=$(date -d '2 hours ago' +'%Y-%m-%d %T')
#END=$(date +'%Y-%m-%d %T')

#PARAMS="-param:startDateTimeParam=$YESTERDAY -param:endDateTimeParam=$TODAY"