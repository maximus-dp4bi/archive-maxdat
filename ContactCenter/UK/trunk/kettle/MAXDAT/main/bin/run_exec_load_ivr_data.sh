#!/bin/bash
. ~/.bash_profile
. $MAXDAT_ROOT/$STCODE/ETL/scripts/ContactCenter/implementation/$STCODE/bin/set_env_vars.sh

BASEDIR=$(dirname $0)

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

function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	rm -f $INIT_OK
	exit 1
}

JOBS_DIR=$MAXDAT_ROOT/$STCODE/ETL/scripts/ContactCenter/main/jobs
JOB=execute_load_Contact_Center_IVR
echo "ETL directory:  $MAXDAT_ETL_PATH"
echo "Job directory:  $JOBS_DIR"

# email-related variables
EMAIL_FROM="austinbaker@maximus.com"
EMAIL_TO="austinbaker@maximus.com"
EMAIL_SUBJECT="Error executing $JOB.kjb"

# log variables
LOG_DIR=$MAXDAT_ROOT/$STCODE/ETL/logs/ContactCenter
echo "Log directory:  $LOG_DIR"
LOG_LEVEL="Detailed"

#Check if IVR Inbound has any files
if [ "$(find $MAXDAT_IVR_INBOUND_DIR -maxdepth 1 -not -type d)" ]; then
	
	sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

	# email on failure, else print success
	rc=$?
	ErrorHandler $rc

else
    echo "$MAXDAT_IVR_INBOUND_DIR is Empty"
fi
