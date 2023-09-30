#!/bin/bash
. ~/.bash_profile
#Run_manual_Task_Types_Load.sh
PROGNAME=$(basename $0 .sh)
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# ---------------------------------
# SVN_FILE_URL        = $URL$ 
# SVN_REVISION        = $Revision$ 
# SVN_REVISION_DATE   = $Date$
# SVN_REVISION_AUTHOR = $Author$
# ---------------------------------

function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
	rm -f $STT_OK
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
KJB_LOG_LEVEL="Detailed"
STT_OK="$MAXDAT_ETL_PATH/${STCODE}_STT_run_check.txt"
STT_FAIL="/tmp/${STCODE}_STT_task_fail.txt"

#mail related variables
email="maxdATsYSTEM@MAXimus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With Manual Task Type Load.sh"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $STT_OK ]] ; then
   echo "Run Aborted - $STT_OK exists"
   exit;
else
   echo "Starting ${STCODE} - run_bpm.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $STT_FAIL
   touch $STT_OK
fi

if [[ $? -eq 0 ]]
then 
  #ensure the directory structure matches and the desired kjb/ktr files are specified
  $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/Process_StandardTaskTypes_Runall.kjb $KTR_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Process_StandardTaskTypes_Runall_$(date +%Y%m%d_%H%M%S).log &
   wait
  if [[ -e $STT_FAIL ]]
  then
	#a child process failed, abort mission
	echo "$STCODE - One or more subtasks failed.  Check error logs and $STT_FAIL for more details." >> $EMAIL_MESSAGE
	rm -f $STT_OK
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	error_exit "$LINENO: An error has occurred."
  else
	#success, move on
	echo "$STCODE - Manual Task Type Load completed successfully."
	rm -f $STT_OK
	exit 0

fi	
  else
	#mail something went wrong with the init
	echo "Process_StandardTaskTypes_Runall.kjb failed in ${STCODE}EC, review error log for additional detail." >> $EMAIL_MESSAGE
	rm -f $STT_OK
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	error_exit "$LINENO: An error has occurred."
fi
rm -f $STT_OK

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
