#!/bin/bash
. ~/.bash_profile
#run_bpm.sh
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

#set up the environment
#PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_PATH/IL/ETL/scripts
LOG_DIR=$MAXDAT_ETL_PATH/IL/ETL/logs
ERR_DIR=$MAXDAT_ETL_PATH/IL/ETL/errors
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

INIT_OK="$CUSTOM_DIR/il_run_init_check.txt"
CHILD_FAIL="/tmp/il_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/il_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With il_run_bpm.sh"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#init check
#assumption that bpm_init_check.kjb and Run_Initiatization.kjb are present in $CUSTOM_DIR
#$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/bpm_Init_check.kjb >> $LOG_DIR/bpm_init_check_$(date +%Y%m%d_%H%M%S).log
$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/bpm_Init_check.kjb" -level="$DETAIL_LOG_LEVEL"  >> $LOG_DIR/il_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#creates il_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - IL bpm_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
    exit $rc
fi

if [[ $rc == 0 && -e $INIT_OK ]]
then
$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/Run_Initialization.kjb >> $LOG_DIR/IL_Run_Initialization_$(date +%Y%m%d_%H%M%S).log
	if [[ $? -eq 0 ]]
	then 
	#ensure the directory structure matches and the desired kjb/ktr files are specified
	$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ManageWork/ManageWork_RUNALL.kjb >> $LOG_DIR/ManageWork_RUNALL_$(date +%Y%m%d_%H%M%S).log &
	$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ProcessMailFaxDoc/Process_mail_fax_doc_runall.kjb >> $LOG_DIR/Process_mail_fax_doc_runall_$(date +%Y%m%d_%H%M%S).log &
	$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ProcessIncidents/Process_Incidents_RUN_ALL.kjb >> $LOG_DIR/Process_Incidents_RUN_ALL_$(date +%Y%m%d_%H%M%S).log &
	$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ManageJobs/ManageJobs_RunAll.kjb >> $LOG_DIR/ManageJobs_RunAll_$(date +%Y%m%d_%H%M%S).log &
	$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ProcessLetters/Process_Letters_runall.kjb >> $LOG_DIR/Process_Letters_runall_$(date +%Y%m%d_%H%M%S).log &
	$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/SupportClientInquiry/ClientInquiry_Main_RUNALL.kjb >> $LOG_DIR/ClientInquiry_Main_RUNALL_$(date +%Y%m%d_%H%M%S).log &	
        #$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ManageEnrollmentActivity/ProcessManageEnroll_RUNALL.kjb >> $LOG_DIR/ProcessManageEnroll_RUNALL_$(date +%Y%m%d_%H%M%S).log &	
    
        #$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ProcessApplication/ProcessApp_RUNALL.kjb >> $LOG_DIR/ProcessApp_RUNALL_$(date +%Y%m%d_%H%M%S).log & 
        #$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/MissingInfo/ProcessMI_RUNALL.kjb >> $LOG_DIR/ProcessMI_RUNALL_$(date +%Y%m%d_%H%M%S).log & 
        #$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/StateReview/ProcessStateReview_RUNALL.kjb >> $LOG_DIR/ProcessStateReview_RUNALL_$(date +%Y%m%d_%H%M%S).log & 
	#ManageInboundInfo needs a kjb/ktr
	#$CUSTOM_DIR/run_kjb.sh ManageInboundInfo/ManageInboundInfo2.kjb & 
	#$CUSTOM_DIR/run_ktr.sh StateReview/StateReview_init_sys_stg.ktr & 
	#Initiate_Renewal needs a kjb/ktr
	#$CUSTOM_DIR/run_kjb.sh Initiate_Renewal/Initiate_Renewal2.kjb &  
	#SendInfoToTP needs a kjb/ktr
	#$CUSTOM_DIR/run_kjb.sh SendInfoToTP/SendInfoToTP2.kjb &
	wait
		if [[ -e $CHILD_FAIL ]]
		then
			#a child process failed, abort mission
			echo "IL - One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> $EMAIL_MESSAGE
			mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
			cat $EMAIL_MESSAGE
			rm -f $INIT_OK
			#exit
			error_exit "$LINENO: An error has occurred."
		else
			#success, move on
			echo "Child processes completed successfully."
			rm -f $INIT_OK
			exit 0
		fi	
	else
		#mail something went wrong with the init
		echo "Run_Initialization.kjb failed in ILEB, review error log for additional detail." >> $EMAIL_MESSAGE
		mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
		cat $EMAIL_MESSAGE
		rm -f $INIT_OK
		#exit
		error_exit "$LINENO: An error has occurred."
	fi 
else
#mail here, it didn't work, no connectivity
echo "bpm_init_check.kjb failed in ILEB, review error log for additional detail." >> $EMAIL_MESSAGE
mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
cat $EMAIL_MESSAGE
error_exit "$LINENO: An error has occurred in ILEB. run_bpm.sh"
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
