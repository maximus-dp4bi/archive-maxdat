#!/bin/bash
#run_kjb.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/NYEC7/scripts/run_kjb7.sh $
# $Revision: 21204 $
# $Date: 2017-09-14 16:20:32 -0600 (Thu, 14 Sep 2017) $
# $Author: iv136523 $
WORK=`pwd`
source $WORK/.setenv_var7
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


# ----  MAIL VARIABLES  -----
# EMAIL="MAXDatSystem@maximus.com"
# EMAIL="prithviadhikarla@maximus.com"
#EMAIL_MESSAGE="/tmp/${ST_CODE}_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${ST_CODE}_run_bpm7.sh in $ENV_CODE"

KJB_FILENAME=$1
LOG_LEVEL=$2
LOG_NAME=`echo $1|awk -F"/" '{print substr($NF,1,length($NF)-4)}'`_$(date +%Y%m%d_%H%M%S)
LOG_FILE='${MAXDAT_ETL_LOGS}/${LOG_NAME}.log'
#--ERRORS_FOUND="/tmp/$STCODE_child_task_fail.txt"
ERRORS_FOUND=$CHILD_FAIL
#test
echo $ERRORS_FOUND
if [[ $# -ne 1 ]] 
then
    echo  "Usage: run_kjb.sh <path><filename>"
    echo "Example: run_kjb7.sh ManageWork/Run_ManageWork.kjb"
     exit  1
else
echo "Running $KJB_FILENAME using ${PROGNAME}"
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$KJB_FILENAME"  -level="$LOG_LEVEL"
kjbrc=$?
if [[ $kjbrc != 0 ]] ; then
        echo "$kjbrc ${1/\//}" >> $ERRORS_FOUND
        echo "$KJB_FILENAME failed with a result code: $kjbrc. Environment: $ENV_CODE, Server: $HOSTNAME" >> $EMAIL_MESSAGE
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
        error_exit "$LINENO: An error has occurred."
        exit $kjbrc

else
  echo "Finished running $KJB_FILENAME using run_kjb7.sh"

fi
fi

exit 0
