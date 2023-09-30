#!/bin/bash
. ~/.bash_profile
#il_run_bpm.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$
PROGNAME=$(basename $0 .sh)
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

#Complete the environment - Specific to IL only
#---------------------------
#redefining these paths here to keep them separate frm NY
export STCODE=IL
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/ETL/logs
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/$STCODE/ETL/scripts
PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME
#--------------------------

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_check.txt"
CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm.sh in $ENV_CODE"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   exit;
else
   echo "Starting ${STCODE}_run_bpm.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_OK
fi

#init check
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/${STCODE}_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#creates il_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - ${STCODE}_BPM_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
	rm -f $INIT_OK
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
else
   $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/Run_Initialization.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/${STCODE}_Run_Initialization_$(date +%Y%m%d_%H%M%S).log
   if [[ $? -eq 0 ]]
   then
	#ensure the directory structure matches and the desired kjb/ktr files are specified
	$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ManageWork/ManageWork_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ManageWork_RUNALL_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessMailFaxDoc/Process_mail_fax_doc_runall.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Process_mail_fax_doc_runall_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessIncidents/Process_Incidents_RUN_ALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Process_Incidents_RUN_ALL_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ManageJobs/ManageJobs_RunAll.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ManageJobs_RunAll_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessLetters/ProcessLetters_RUNALL_ONCE_A_DAY.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Process_Letters_runall_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/SupportClientInquiry/ClientInquiry_Main_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ClientInquiry_Main_RUNALL_$(date +%Y%m%d_%H%M%S).log &	
	#$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ManageEnrollmentActivity/ProcessManageEnroll_RUNALL_ONCE_A_DAY.kjb $KJB_LOG_LEVEL  >> $MAXDAT_ETL_LOGS/ProcessManageEnroll_RUNALL_ONCE_A_DAY_$(date +%Y%m%d_%H%M%S).log &	
	$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessOnlineInfo/ProcessOnlineInfo_RunAll.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ProcessOnlineInfo_RunAll_$(date +%Y%m%d_%H%M%S).log &
	#$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/OutboundCalls/OutboundCalls_Runall.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/OutboundCalls_Runall_$(date +%Y%m%d_%H%M%S).log &
	wait
	if [[ -e $CHILD_FAIL ]];
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
	echo "Run_Initialization.kjb failed in ${STCODE}EB, review error log for additional detail." >> $EMAIL_MESSAGE
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

