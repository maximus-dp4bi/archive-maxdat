#!/bin/bash
#source $IL_SETENV this should be sourced in cron_

# IL_run_bpm7.sh
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
#	Accepts 1 argument: string containing descriptive error message
#	----------------------------------------------------------------

	echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
	rm -f $INIT_OK
	exit 1
}

# ---- Override Generic email variables  -----
#EMAIL="CameronHill@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm${PDI_VERSION}-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm${PDI_VERSION}.sh in $ENV_CODE"

# Checking for run file - Abort if it exists, otherwise create it
if [[ -e $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   exit;
else
   echo "Starting $PROGNAME in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_OK
fi

# BPM init check
 $MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/bpm_Init_check.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/${STCODE}_bpm_init_check_PDI${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log

# Check the return value from Init Check - if it's not good (not 0), email error
rc=$?
if [[ $rc != 0 ]] ; then	
        echo "bpm_Init_check.kjb failed with a result code: $rc. Environment: $ENV_CODE, Server: $HOSTNAME" >> $EMAIL_MESSAGE
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
        error_exit "$LINENO: An error has occurred."        
        exit $rc
        
else
 # true
 $MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/Run_Initialization.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/${STCODE}_Run_Initialization${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log
   if [[ $? -eq 0 ]]
   then
	#ensure the directory structure matches and the desired kjb/ktr files are specified
	$MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/ManageWork/ManageWork_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ManageWork_RUNALL${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/ProcessMailFaxDoc/Process_mail_fax_doc_runall.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Process_mail_fax_doc_runall${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/ProcessIncidents/Process_Incidents_RUN_ALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Process_Incidents_RUN_ALL${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/ManageJobs/ManageJobs_RunAll.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ManageJobs_RunAll${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/ProcessLetters/ProcessLetters_RUNALL_ONCE_A_DAY.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Process_Letters_runall${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/SupportClientInquiry/ClientInquiry_Main_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ClientInquiry_Main_RUNALL${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log &	
	#$MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/ManageEnrollmentActivity/ProcessManageEnroll_RUNALL_ONCE_A_DAY.kjb $KJB_LOG_LEVEL  >> $MAXDAT_ETL_LOGS/ProcessManageEnroll_RUNALL${PDI_VERSION}_ONCE_A_DAY_$(date +%Y%m%d_%H%M%S).log &	
	$MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/ProcessOnlineInfo/ProcessOnlineInfo_RunAll.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ProcessOnlineInfo_RunAll_$(date +%Y%m%d_%H%M%S).log &
	$MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/OutboundCalls/OutboundCalls_Runall.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/OutboundCalls_Runall${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log &
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

echo "Finished $PROGNAME in $ENV_CODE."
exit 0

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
