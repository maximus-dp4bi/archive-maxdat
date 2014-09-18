#!/bin/bash

BASEDIR=$(dirname $0)
. $BASEDIR/set_env_vars.sh

# This program will run the Kettle job to load metric spreadsheets delivered from the projects.

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

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
			error_exit "An error has occurred while running $JOB.kjb"
			kitchen_status $1
	else
			# success
			echo "$(date +%Y%m%d_%H%M%S):  $JOB.kjb completed successfully"
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

JOBS_DIR=$MOTS_ETL_PATH/ContactCenter/main/jobs
JOB=execute_load_Metric_Spreadsheet
echo "ETL directory:  $MOTS_ETL_PATH"
echo "Job directory:  $JOBS_DIR"

# email-related variables
EMAIL_FROM="austinbaker@maximus.com"
EMAIL_TO="austinbaker@maximus.com"
EMAIL_SUBJECT="Error executing $JOB.kjb"

# log variables
LOG_DIR=$MOTS_ETL_LOGS/ContactCenter
echo "Log directory:  $LOG_DIR"
LOG_LEVEL="Detailed"

#Check if v1 Inbound has any files
if [ "$(find $AMP_v1_TEMPLATE_INBOUND_DIR -maxdepth 1 -not -type d)" ]; then
	
	sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

	# email on failure, else print success
	rc=$?
	ErrorHandler $rc

else
    echo "$AMP_v1_TEMPLATE_INBOUND_DIR is Empty"
fi

#Check if v2 Inbound has any files
if [ "$(ls -A $AMP_v2_TEMPLATE_INBOUND_DIR)" ]; then
	#run the v2 job 
	JOB=execute_load_Metric_Spreadsheet_v2
	sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

	rc=$?
	ErrorHandler $rc
else
    echo "$AMP_v2_TEMPLATE_INBOUND_DIR is Empty"
fi
