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

METRICS_INBOUND_DIR=$MAXDAT_EXPORT_INBOUND_DIR/metrics

#Check if v1 Inbound has any files
if [ "$(find $METRICS_INBOUND_DIR -maxdepth 1 -not -type d)" ]; then

	JOBS_DIR=$MOTS_ETL_PATH/ContactCenter/main/jobs
	JOB=execute_load_MAXDAT_Metrics
	echo "ETL directory:  $MOTS_ETL_PATH"
	echo "Job directory:  $JOBS_DIR"

	# email-related variables
	EMAIL_FROM="MAXDatSystem@maximus.com"
	EMAIL_TO="MAXDatSystem@maximus.com"
	EMAIL_SUBJECT="Error executing $JOB.kjb"

	# log variables
	LOG_DIR=$MOTS_ETL_LOGS/ContactCenter
	echo "Log directory:  $LOG_DIR"
	LOG_LEVEL="Detailed"

	sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL" >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

	# email on failure, else print success
	rc=$?
	if [[ $rc != 0 ]]
	then
        	# failure
        	echo "ERROR:  See LOG FILE for details"
        	kitchen_status $rc | mailx -r "$EMAIL_FROM" -s "$EMAIL_SUBJECT" "$EMAIL_TO"
        	error_exit "An error has occurred while running $JOB.kjb"
        	kitchen_status $rc
	else
        	# success
        	echo "$(date +%Y%m%d_%H%M%S):  $JOB.kjb completed successfully"
		kitchen_status $rc
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
