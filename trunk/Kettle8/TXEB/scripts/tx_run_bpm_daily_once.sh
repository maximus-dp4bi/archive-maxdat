#!/bin/ksh
#. ~/.profile
. $HOME/.profile
#tx_run_bpm.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/tx_run_bpm_daily_once.sh $
# $Revision: 15999 $
# $Date: 2015-12-14 13:50:40 -0800 (Fri, 14 Dec 2015) $
# $Author: sr18956 $
PROGNAME=$(basename $0 .sh)
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

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_check_daily_once.txt"
CHILD_FAIL="/tmp/${STCODE}_daily_child_once_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm_daily_once-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm_daily_once.sh in $ENV_CODE"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   exit;
else
   echo "Starting ${STCODE}_run_bpm_daily.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_OK
fi


#ensure the directory structure matches and the desired kjb/ktr files are specified
$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ManageAlerts/ManageAlerts_Create_Instance.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ManageAlerts_Create_Instance_$(date +%Y%m%d_%H%M%S).log &

wait
if [[ -e $CHILD_FAIL ]]
 then
    #a child process failed, abort mission
	echo "$STCODE - One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> $EMAIL_MESSAGE
	rm -f $INIT_OK
    mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
    cat $EMAIL_MESSAGE
    #exit
    error_exit "$LINENO: An error has occurred."
 else
   #success, move on
	echo "$STCODE - Daily Child processes completed successfully."
    rm -f $INIT_OK
    exit 0
fi	
