#!/bin/bash
BASEDIR=$(dirname $0)
. $BASEDIR/set_env_vars.sh

# This program will run the Kettle job necessary to aggregate daily MAXDAT data into weekly metrics

PROGNAME=$(basename $0)

echo "Start of program:  $PROGNAME"

# function to display the Kitchen return code
kitchen_status()
{
# kitchen status codes
kitchenStatusDefs[1]="Errors occurred during processing"
kitchenStatusDefs[2]="An unexpected error occurred during loading or running of the job"
kitchenStatusDefs[7]="The job couldn't be loaded from XML or the Repository"
kitchenStatusDefs[8]="Error loading steps or plugins (error in loading one of the plugins mostly)"
kitchenStatusDefs[9]="Command line usage printing"
kitchenStatusDefs[0]="Success"
echo "PDI reports the following error:  $1 - " ${kitchenStatusDefs[$1]}
}

# function for exit due to fatal program error
function error_exit
{
#       ----------------------------------------------------------------
#               Accepts 1 argument:
#                       string containing descriptive error message
#       ----------------------------------------------------------------

        echo "see LOG FILE for details."
        echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
        exit 1
}

METRICS_INBOUND_DIR=$AMP_METRICS_XML_INBOUND_DIR/xml

# Adding AMP XML ADMIN DL for failure notifications
EMAIL="ampxmladmin@maximus.com"
EMAIL_MESSAGE="AMP XML Load"

RUN_DATE=$(date +"%m/%d/%Y %H:%M:%S" --date='today')
RUN_DATE_LOG=$(date +"%Y%m%d_%H%M%S" --date='today')

#Check if  Inbound has any files
if [ "$(find $METRICS_INBOUND_DIR -maxdepth 1 -not -type d)" ]; then

	JOBS_DIR=$MOTS_ETL_PATH/ContactCenter/main/jobs
	JOB=execute_load_Metric_Xml
	echo "ETL directory:  $MOTS_ETL_PATH"
	echo "Job directory:  $JOBS_DIR"

	# email-related variables
	EMAIL_FROM="AMP_XML_Load"
	# EMAIL_TO="MAXDatSystem@maximus.com"
	EMAIL_SUBJECT="Error executing $JOB.kjb"

	# log variables
	LOG_DIR=$MOTS_ETL_LOGS/ContactCenter
	echo "Log directory:  $LOG_DIR"
	LOG_LEVEL="Detailed"
	LOG_NAME=${JOB}_${RUN_DATE_LOG}.log
	echo "$LOG_NAME"
	EMAIL_LOG_NAME=AMP_XML_Load_Error.log
	ENV_CODE_U=$(echo $ENV_CODE | tr '[a-z]' '[A-Z]')	

	EMAIL_MESSAGE="${LOG_DIR}/${JOB}_EMAIL.log"
	echo "AMP XML Load Job Status" >> $EMAIL_MESSAGE
	echo "JOB : $JOB" >> $EMAIL_MESSAGE
	echo "DATE : $RUN_DATE" >> $EMAIL_MESSAGE
	echo "LOG File: ${LOG_DIR}/${LOG_NAME}" >> $EMAIL_MESSAGE

	sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL" >> "${LOG_DIR}/${LOG_NAME}"

	# email on failure, else print success
	rc=$?
	if [[ $rc != 0 ]]
	then
        	# failure
        	echo "ERROR:  See LOG FILE for details"
        	kitchen_status $rc 
        		kitchen_status $rc >> $EMAIL_MESSAGE
			if IFS= read -r line < "${AMP_METRICS_XML_EMAIL_DIR}/${EMAIL_LOG_NAME}"
			then
			  if [ -z "$line" ]
			  then
				echo "No error data"
			  else
			        echo "AMP XML Load Error, See attached log file for details." >> $EMAIL_MESSAGE
			        EMAIL_SUBJECT="$ENV_CODE_U - AMP XML Load Error"
				mail -r "$EMAIL_FROM" -a "${AMP_METRICS_XML_EMAIL_DIR}/${EMAIL_LOG_NAME}" -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
			  fi
			else
				echo "No error data"
			fi
        		rm -f $EMAIL_MESSAGE
        
        	error_exit "An error has occurred while running $JOB.kjb"
        	kitchen_status $rc
	else
        	# success
        	echo "$(date +%Y%m%d_%H%M%S):  $JOB.kjb completed successfully"
		kitchen_status $rc
		if IFS= read -r line < "${AMP_METRICS_XML_EMAIL_DIR}/${EMAIL_LOG_NAME}"
		then
		  if [ -z "$line" ]
		  then
			echo "No error data"
		  else
			echo "AMP XML Load Error, See attached log file for details." >> $EMAIL_MESSAGE
			EMAIL_SUBJECT="$ENV_CODE_U - AMP XML Load Error"
			mail -r "$EMAIL_FROM" -a "${AMP_METRICS_XML_EMAIL_DIR}/${EMAIL_LOG_NAME}" -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
		  fi
		else
			echo "No error data"
		fi
		rm -f $EMAIL_MESSAGE
	fi
	
else
    echo "$METRICS_INBOUND_DIR is Empty"
fi

#kitchen status code
# 0 The job ran without a problem.
# 1 Errors occurred during processing
# 2 An unexpected error occurred during loading or running the job
# 7 The job couldn't be loaded from XML or the Repository
# 8 Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 Command line usage printing
