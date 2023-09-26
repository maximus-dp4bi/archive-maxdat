#!/bin/bash
#BASEDIR=$(dirname $0)
#. $BASEDIR/set_env_vars.sh

# This program will run the Kettle job to load Clear2Work Survey files

location='/u01/maximus/maxdat/AMP_ETL/Config'
source ${location}/.set_env

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

ErrorHandler() {
	if [[ $1 != 0 ]]
	then
			# failure
			echo "ERROR:  See LOG FILE for details"
			kitchen_status $1 | mailx -r "$EMAIL_FROM" -s "$EMAIL_SUBJECT" "$EMAIL_TO"
			error_exit "An error has occurred while running $JOB.kjb in the $ENV_CODE environment"
			kitchen_status $1
	else
			# success
			echo "$(date +%Y%m%d_%H%M%S):  $JOB.kjb completed successfully in the $ENV_CODE environment"
		kitchen_status $1
	fi
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

CLEAR2WORK_INBOUND_DIR=$Clear2Work_FILES
RUN_DATE=$(date +"%m/%d/%Y %H:%M:%S" --date='today')
RUN_DATE_LOG=$(date +"%Y%m%d_%H%M%S" --date='today')

	JOBS_DIR=$Clear2Work_ETL_PATH/'jobs'
	JOB=Clear2Work_Process_Survey_Files
	echo "ETL directory:  $Clear2Work_ETL_PATH"
	echo "Job directory:  $JOBS_DIR"

	# email-related variables
	EMAIL_FROM="maxdatsystem@maximus.com"
	EMAIL_TO="maxdatsystem@maximus.com"
	EMAIL_SUBJECT="Error executing $JOB.kjb in the $ENV_CODE environment"
        EMAIL_SUBJECT_FILE_NOT_FOUND="ALERT! – C2W $ENV_CODE - No Survey files found in the Inbound Directory"

	# log variables
	LOG_DIR=$Clear2Work_ETL_LOGS
	echo "Log directory:  $LOG_DIR"
	LOG_LEVEL="Detailed"
	LOG_NAME=${JOB}_${RUN_DATE_LOG}.log
	echo "$LOG_NAME"


#Check if  Inbound has any files
if [ "$(find $CLEAR2WORK_INBOUND_DIR -maxdepth 1 -not -type d -name "Part*")" ]; then

	sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL" >> "${LOG_DIR}/${LOG_NAME}"

	# email on failure, else print success
	rc=$?
	ErrorHandler $rc


else
    echo "$CLEAR2WORK_INBOUND_DIR is Empty"
   echo ""| mailx -r "$EMAIL_FROM" -s "$EMAIL_SUBJECT_FILE_NOT_FOUND" "$EMAIL_TO"
fi



