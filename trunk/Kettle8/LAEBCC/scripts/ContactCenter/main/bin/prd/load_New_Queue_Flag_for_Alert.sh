#!/bin/bash
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/ContactCenter/trunk/kettle/MAXDAT/main/bin/load_New_Queue_Flag_for_Alert.sh $
# $Revision: 10689 $
# $Date: 2015-10-28 10:02:52 -0700 (Wed, 28 Oct 2015) $
# $Author: lg74078 $
PROGNAME=$(basename $0 .sh)

. /u01/maximus/maxdat-prd/LAEBCC8/scripts/ContactCenter/implementation/LAEB/bin/.set_env
function error_exit
{

#       ----------------------------------------------------------------
#       Function for exit due to fatal program error
#               Accepts 1 argument:
#                       string containing descriptive error message
#       ----------------------------------------------------------------


        echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
        rm -f $INIT_OK
        exit 1
}

BASEDIR=$(dirname $0)
echo $BASEDIR

# This program will run the Kettle job that executes adhoc jobs

INIT_NQFA_OK="${STCODE}_run_newqueueflagalert_check.txt"

PROGNAME=$(basename $0)
#echo "Start of program:  $(basename $0)"
# Checking for run file - Abort if it exists, otherwise create it
if [[ -e $INIT_NQFA_OK ]] ; then
   echo "Run Aborted - $INIT_NQFA_OK exists"
   exit;
else
   echo "Starting ${STCODE}_run_New_Queue_Flag_for_Alert.sh in ${ENV_CODE}."
   touch $INIT_NQFA_OK
fi

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs/staging/Avaya
JOB=load_New_Queue_Flag_for_Alert
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo $LOG_DIR
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log" & wait

#Check return value from load_New_Queue_Flag_for_Alert - if 0,success,remove check file. If not 0, error
rc=$?

if [[ $rc = 0 ]] ; then
 echo "${STCODE}_load_New_Queue_Flag_for_Alert.kjb completed successfully"
   rm -f $INIT_NQFA_OK
   exit $rc
else
 echo "${STCODE}_load_New_Queue_Flag_for_Alert.kjb failed to run,review error log for additional detail."
fi

