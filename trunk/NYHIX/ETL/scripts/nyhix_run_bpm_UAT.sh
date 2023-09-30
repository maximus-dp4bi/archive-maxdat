#!/bin/ksh
. ~/.bash_profile
#nyhix_run_bpm.sh
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


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	rm -f $INIT_OK
	exit 1
}

export KETTLE_HOME=$KETTLE_NYHIX_HOME

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
KJB_LOG_ROWLEVEL="Rowlevel"
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
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/bpm_init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - BPM_Init_check.kjb, aborting run in $STCODE" >> $EMAIL_MESSAGE
	rm -f $INIT_OK
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
else
   $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/Run_Initialization.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Run_Initialization_$(date +%Y%m%d_%H%M%S).log
   if [[ $? -eq 0 ]]
   then
	#ensure the directory structure matches and the desired kjb/ktr files are specified
	#$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ManageWork/ManageWork_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ManageWork_RUNALL_$(date +%Y%m%d_%H%M%S).log &
	#$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MailFaxBatch/MailFaxBatch_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/MailFaxBatch_RUNALL_$(date +%Y%m%d_%H%M%S).log &
	#$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MailFaxDoc/Process_mail_fax_doc_runall.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/MailFaxDoc_RUNALL_$(date +%Y%m%d_%H%M%S).log &
    #$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessComplaints/Process_Complaints_RUN_ALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Process_Complaints_RUN_ALL$(date +%Y%m%d_%H%M%S).log &
    $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/Appeals/Process_Appeals_RUN_ALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Process_Appeals_RUN_ALL$(date +%Y%m%d_%H%M%S).log &
	#$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/IDR/IDR_Incidents_RUN_ALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/IDR_Incidents_RUN_ALL_$(date +%Y%m%d_%H%M%S).log &
	#$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessLetters/ProcessLetters_RUNALL_ONCE_A_DAY.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ProcessLetters_RUNALL_ONCE_A_DAY$(date +%Y%m%d_%H%M%S).log &
	#$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MW_V2/MW_V2_RUNALL_TIMER.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/MW_V2_RUNALL_TIMER_$(date +%Y%m%d_%H%M%S).log &
	wait
	  $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProductionPlanning/PP_Actuals_RUNALL_v2.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/PP_Actuals_RUNALL_v2_$(date +%Y%m%d_%H%M%S).log &
	  wait
		if [[ -e $CHILD_FAIL ]]
		then
			#a child process failed, abort mission
			echo "$STCODE - One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> $EMAIL_MESSAGE
			mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
			cat $EMAIL_MESSAGE
			rm -f $INIT_OK
			#exit
			error_exit "$LINENO: $STCODE - A Child error has occurred."
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
		error_exit "$LINENO: $STCODE - An Init error has occurred."
	fi 
fi

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
