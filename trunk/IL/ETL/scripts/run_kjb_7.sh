#!/bin/bash
#run_kjb.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
PROGNAME=$(basename $0)
function kitchen_status()
{
#kitchen status codes
kitchenStatusDefs[1]='Errors occurred during processing'
kitchenStatusDefs[2]='An unexpected error occurred during loading or running of the job'
kitchenStatusDefs[7]="The job couldn't be loaded from XML or the Repository"
kitchenStatusDefs[8]='Error loading steps or plugins (error in loading one of the plugins mostly)'
kitchenStatusDefs[9]='Command line usage printing'
kitchenStatusDefs[0]='Success'
echo ${kitchenStatusDefs[$1]}
}

function error_exit
{

#       ----------------------------------------------------------------
#       Function for exit due to fatal program error
#               Accepts 1 argument:
#                       string containing descriptive error message
#       ----------------------------------------------------------------

        echo "see: $LOG_NAME for details."
        echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
        exit 1
}
#---- IL Specific  --------
PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pdi-ce-7.0.0.0-25/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME
#---------------------------

LOG_LEVEL=$2
LOG_NAME=`echo $1|awk -F"/" '{print substr($NF,1,length($NF)-4)}'`_$(date +%Y%m%d_%H%M%S)
LOG_FILE="${MAXDAT_ETL_LOGS}/${LOG_NAME}.log"
ERRORS_FOUND="/tmp/${STCODE}_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${LOG_NAME}-${STCODE}-ERROR-LOG.txt"
EMAIL_SUBJECT="${STCODE}-Errors With $LOG_NAME in $ENV_CODE"

rm -f $EMAIL_MESSAGE

# Check for any arguments
# first arg is the Kettle Job file name
if [[ $# -ne 2 ]]
then
   echo 'Usage: run_kjb.sh <path><filename> <logging level>'
   echo 'Example: run_kjb.sh ManageWork/Run_ManageWork.kjb Detailed'
   exit  1
else
   $MAXDAT_KETTLE_DIR/kitchen.sh -file="$1"  -level="$LOG_LEVEL"
   kjbrc=$?
      if [[ $kjbrc != 0 ]]
      then
          #failure
          echo "$kjbrc ${1/\//}" >> $ERRORS_FOUND
          echo "${STCODE}-ERROR IN $1, See $LOG_NAME for details." >> $EMAIL_MESSAGE
          kitchen_status $kjbrc >> $EMAIL_MESSAGE
          mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
          cat $EMAIL_MESSAGE
          error_exit "$LINENO: An error has occurred in $STCODE. run_kjb.sh"
       else
          #success
          echo "$(date +%Y%m%d_%H%M%S) $1 $STCODE Completed Successfully"
          kitchen_status $kjbrc
      fi
fi
exit 0
