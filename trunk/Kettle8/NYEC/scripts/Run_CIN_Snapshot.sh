#!/bin/bash
. ~/.bash_profile
source /u01/maximus/maxdat/NYEC8/config/.set_env 
PROGNAME=$(basename $0 .sh)
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/NYEC/ETL/scripts/Run_CIN_Snapshot.sh $
# $Revision: 26097 $
# $Date: 2019-01-29 18:07:51 -0400 (Tue, 29 Jan 2019) $
# $Author: aa24065 $
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
	rm -f $CINSNAP_INIT_OK
	exit 1
}

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Basic"
CINSNAP_INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_cinsnap_check.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_SUBJECT="Errors With Run_CIN_Snapshot in ${ENV_CODE}."

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $CINSNAP_INIT_OK ]] ; then
   echo "Run Aborted - $CINSNAP_INIT_OK exists"
   CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"
   EMAIL_MESSAGE="Run_CIN_Snapshot Aborted in - ${ENV_CODE}- $CINSNAP_INIT_OK exists"
   mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
   exit;
else
   echo "Starting ${STCODE} - Run_CIN_Snapshot in ${ENV_CODE}."
   touch $CINSNAP_INIT_OK
fi

$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/Process_CIN_Snapshot.kjb $KTR_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Initialization/Process_CIN_Snapshot_$(date +%Y%m%d_%H%M%S).log
echo "Run_CIN_Snapshot completed in ${ENV_CODE}."

rm -f $CINSNAP_INIT_OK

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

