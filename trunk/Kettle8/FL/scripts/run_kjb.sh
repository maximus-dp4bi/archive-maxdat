#!/bin/bash
#run_kjb.sh
. /u01/maximus/maxdat/FL/scripts/setenv_var.sh
PROGNAME=$(basename $0)
function kitchen_status()
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

#----------------------------------------------------------------
#Function for exit due to fatal program error
#Accepts 1 argument:
#string containing descriptive error message
#----------------------------------------------------------------

     echo "see: $LOG_FILE for details."
     echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
     exit 1
}

LOG_DIR=$MAXDAT_ETL_LOGS
LOG_LEVEL="Detailed"
ERRORS_FOUND="/tmp/child_task_fail.txt"

#mail related variables
EMAIL="PhilipWSmith@maximus.com"
EMAIL_MESSAGE="/tmp/${1/\//}-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${1/\//}"

rm -f $EMAIL_MESSAGE

# Check for any arguments  
# first arg is the Kettle Job file name
if [[ $# -ne 1 ]]
then
        echo "Usage: run_kjb.sh <path><filename>"
        echo "Example: run_kjb.sh ManageWork/Run_ManageWork.kjb"
        exit  1
else
LOG_FILE="$LOG_DIR/${1/\//}_$(date +%Y%m%d_%H%M%S).log"
       $SCRIPTS_DIR/kitchen.sh -file="$1"  -level="$LOG_LEVEL" 
       #   $SCRIPTS_DIR/kitchen.sh -file="$1" -log="$LOG_FILE" -level="$LOG_LEVEL" 
       kjbrc=$?
       if [[ $kjbrc != 0 ]]
       then #failure
            echo "$kjbrc ${1/\//}" >> $ERRORS_FOUND
            echo "ERROR IN $1, See $LOG_FILE for details." >> $EMAIL_MESSAGE
            kitchen_status $kjbrc >> $EMAIL_MESSAGE
            mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
            cat $EMAIL_MESSAGE
            error_exit "$LINENO: An error has occurred. run_kjb.sh"
        else
       #success
           echo "$(date +%Y%m%d_%H%M%S) $1 Completed Successfully"
                kitchen_status $kjbrc
       fi 
fi
exit 0
