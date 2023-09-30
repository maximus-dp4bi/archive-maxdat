#!/bin/bash
. ~/.bash_profile
source /u01/maximus/maxbi-uat/ETL/scripts/setenv_var 
#run_bpm.sh (NYEC)
PROGNAME=$(basename $0 .sh)
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$
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


#Complete the environment - Specific to NY only
#---------------------------
#redefining these paths here to keep them separate frm IL
export STCODE=NY
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_DIR/ETL/logs
export MAXDAT_ETL_PATH=$MAXDAT_ETL_DIR/ETL/scripts
PATH=$KETTLE_NY_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_NY_HOME
#--------------------------

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Basic"
CINSNAP_INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_cinsnap_check.txt"
#CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
#EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With run_bpm.sh"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $CINSNAP_INIT_OK ]] ; then
   echo "Run Aborted - $CINSNAP_INIT_OK exists"
   exit;
else
   echo "Starting ${STCODE} - run_bpm.sh in ${ENV_CODE}."
   #rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $CINSNAP_INIT_OK
fi

$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/Process_CIN_Snapshot.kjb $KTR_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Process_CIN_Snapshot_$(date +%Y%m%d_%H%M%S).log

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

