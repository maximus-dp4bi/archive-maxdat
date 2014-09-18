#!/bin/bash
. ~/.bash_profile

# This program will run the Kettle job smoke test the MOTS database

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
echo "PDI reports the following status:  $1 - " ${kitchenStatusDefs[$1]}
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

#echo TZ=$TZ+24 date +.%Y/%m/%d

JOBS_DIR=$MOTS_ETL_PATH/ContactCenter/main/jobs
JOB=load_ControlChartParameters
echo "Job directory:  $JOBS_DIR"
echo "ETL directory:  $MOTS_ETL_PATH"

# email-related variables
EMAIL_FROM="austinbaker@maximus.com"
EMAIL_TO="austinbaker@maximus.com"
EMAIL_SUBJECT="Error executing $JOB.kjb"

#log variables
LOG_DIR=$MOTS_ETL_LOGS/ContactCenter
echo "Log directory:  $LOG_DIR"
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="LOG_LEVEL" >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

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
