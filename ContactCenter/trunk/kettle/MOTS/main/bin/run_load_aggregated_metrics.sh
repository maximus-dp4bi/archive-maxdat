#!/bin/bash
. ~/.bash_profile

# This program will run the Kettle job necessary to aggregate daily MAXDAT data into weekly metrics

PROGNAME=$(basename $0)
REPORTTYPE=$1
STARTDATE=$2
ENDDATE=$3

echo "Start of program:  $PROGNAME"
echo "Report type:  $REPORTTYPE"
echo "Run for report period:  $STARTDATE - $ENDDATE"

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

if [[ $# -ne 3 ]]
then
	echo "ERROR - A report type and start and end date parameters are required, e.g.:  sh run_load_contact_center_metrics.sh \"WEEKLY\" YYYY/MM/DD YYYY/MM/DD"
else
	JOBS_DIR=$MOTS_ETL_PATH/ContactCenter/main/jobs/AMP_aggregate_load
	JOB=load_aggregated_Contact_Center_Metrics_By_Reporting_Period
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

	sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL" -param:reportPeriodType="$REPORTTYPE" -param:startDate=$STARTDATE -param:endDate=$ENDDATE >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

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
fi

#kitchen status code
# 0 The job ran without a problem.
# 1 Errors occurred during processing
# 2 An unexpected error occurred during loading or running the job
# 7 The job couldn't be loaded from XML or the Repository
# 8 Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 Command line usage printing
