#!/bin/bash
source /u01/maximus/maxdat/NYEC8/config/.set_env
#run_bpm.sh (NYEC)
PROGNAME=$(basename $0 .sh)
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/NYEC/ETL/scripts/prd_run_bpm.sh $
# $Revision: 10148 $
# $Date: 2014-06-05 12:22:42 -0400 (Fri, 05 Jun 2015) $
# $Author: lg74078 $
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


    echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
    rm -f $INIT_OK
    exit 1
}

#Complete the environment - Specific to NY only
#---------------------------
#redefining these paths here to keep them separate frm IL
#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With run_bpm.sh"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   exit;
else
   echo "Starting ${STCODE} - run_bpm.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_OK
fi

#init check
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_INIT/bpm_Init_check.kjb" -level="$KTR_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/$MODULE_INIT/${STCODE}_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#creates run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
    echo "exited with status: $rc - ${STCODE}_BPM_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
    rm -f $INIT_OK
    mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
    cat $EMAIL_MESSAGE
    exit $rc
else
        #success, move on
        echo "$STCODE - Child processes completed successfully."
        rm -f $INIT_OK
        exit 0
fi
rm -f $INIT_OK

#pan status codes
# 0 	The transformation ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading / running of the transformation
# 3 	Unable to prepare and initialize this transformation
# 7 	The transformation couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing

#kitchen status codes
# 0 	The job ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading or running of the job
# 7 	The job couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing

