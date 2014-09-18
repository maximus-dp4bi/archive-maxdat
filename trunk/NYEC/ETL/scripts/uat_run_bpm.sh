#!/bin/bash
. ~/.bash_profile
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
	rm -f $INIT_OK
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
INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_check.txt"
CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"

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
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KTR_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/${STCODE}_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#creates run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - ${STCODE}_BPM_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
	rm -f $INIT_OK
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
else
  $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/Run_Initialization.kjb $KTR_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Run_Initialization_$(date +%Y%m%d_%H%M%S).log
	if [[ $? -eq 0 ]]
	then 
	  #ensure the directory structure matches and the desired kjb/ktr files are specified
	  $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ManageWork/ManageWork_RUNALL.kjb $KTR_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ManageWork_RUNALL_$(date +%Y%m%d_%H%M%S).log &
        $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessApplication/ProcessApp_RUNALL.kjb $KTR_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ProcessApp_RUNALL_$(date +%Y%m%d_%H%M%S).log & 
        $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MissingInfo/ProcessMI_RUNALL.kjb $KTR_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ProcessMI_RUNALL_$(date +%Y%m%d_%H%M%S).log & 
        $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/StateReview/ProcessStateReview_RUNALL.kjb $KTR_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ProcessStateReview_RUNALL_$(date +%Y%m%d_%H%M%S).log & 
       # $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessComplaints/Process_Complaints_RUN_ALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Process_Complaints_RUN_ALL$(date +%Y%m%d_%H%M%S).log &
        wait
        $MAXDAT_ETL_PATH/run_ktr.sh $MAXDAT_ETL_PATH/ManageWork/ManageWork_Get_Incident_Hdr.ktr $KTR_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ManageWork_Get_Incident_Hdr_$(date +%Y%m%d_%H%M%S).log &
           wait
	  if [[ -e $CHILD_FAIL ]]
	  then
		#a child process failed, abort mission
		echo "$STCODE - One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> $EMAIL_MESSAGE
		rm -f $INIT_OK
		mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
		cat $EMAIL_MESSAGE
		error_exit "$LINENO: An error has occurred."
	  else
		#success, move on
		echo "$STCODE - Child processes completed successfully."
		rm -f $INIT_OK
		exit 0

	fi	
   else
		#mail something went wrong with the init
	echo "Run_Initialization.kjb failed in ${STCODE}EC, review error log for additional detail." >> $EMAIL_MESSAGE
	rm -f $INIT_OK
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	error_exit "$LINENO: An error has occurred."
	fi 
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

