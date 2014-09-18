#!/bin/ksh
#. ~/.bash_profile
. ~/.profile
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
PATH=/u25/app/product/kettle/4.2/data-integration/.kettle/kettle.properties:.:/u25/app/product/kettle/4.2/data-integration/:$PATH
export PATH


export PENTAHO_JAVA_HOME="/u25/app/product/java/j6sdk"
SCRIPTS_DIR="/u25/app/product/kettle/4.2/data-integration"
export SCRIPTS_DIR

#CUSTOM_DIR=$MAXDAT_ETL_PATH/IL/ETL/scripts
#LOG_DIR=$MAXDAT_ETL_PATH/IL/ETL/logs
#ERR_DIR=$MAXDAT_ETL_PATH/IL/ETL/errors
#CUSTOM_DIR=$MAXDAT_ETL_PATH
CUSTOM_DIR=/u25/ETL_Scripts/DEV/scripts
LOG_DIR=/u25/ETL_Logs/DEV
ERR_DIR=/u25/ETL_Logs/DEV/errors
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

INIT_OK="$CUSTOM_DIR/tx_run_init_check.txt"
CHILD_FAIL="/tmp/tx_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/tx_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With tx_run_bpm.sh"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#init check
#assumption that bpm_init_check.kjb and Run_Initiatization.kjb are present in $CUSTOM_DIR
#$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/bpm_Init_check.kjb >> $LOG_DIR/bpm_init_check_$(date +%Y%m%d_%H%M%S).log
ksh $SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/bpm_Init_check.kjb" -level="$DETAIL_LOG_LEVEL"  >> $LOG_DIR/tx_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#creates tx_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - TX bpm_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
    exit $rc
fi
if [[ $rc == 0 && -e $INIT_OK ]]
then
ksh $CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/Run_Initialization.kjb Run_Initialization  >> $LOG_DIR/TX_Run_Initialization_$(date +%Y%m%d_%H%M%S).log
	if [[ $? -eq 0 ]]
	then 
	#ensure the directory structure matches and the desired kjb/ktr files are specified
	$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ManageWork/ManageWork_RUNALL.kjb ManageWork_RUNALL >> $LOG_DIR/ManageWork_RUNALL_$(date +%Y%m%d_%H%M%S).log &
	#$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ProcessMailFaxDoc/Process_mail_fax_doc_runall.kjb Process_mail_fax_doc_runall >> $LOG_DIR/Process_mail_fax_doc_runall_$(date +%Y%m%d_%H%M%S).log &
	#$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ProcessIncidents/Process_Incidents_RUN_ALL.kjb Process_Incidents_RUN_ALL >> $LOG_DIR/Process_Incidents_RUN_ALL_$(date +%Y%m%d_%H%M%S).log &
	$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ManageJobs/ManageJobs_RunAll.kjb ManageJobs_RunAll >> $LOG_DIR/ManageJobs_RunAll_$(date +%Y%m%d_%H%M%S).log &
	$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ProcessLetters/Process_Letters_runall.kjb Process_Letters_runall >> $LOG_DIR/Process_Letters_runall_$(date +%Y%m%d_%H%M%S).log &
	#$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/SupportClientInquiry/ClientInquiry_Main_RUNALL.kjb ClientInquiry_Main_RUNALL >> $LOG_DIR/ClientInquiry_Main_RUNALL_$(date +%Y%m%d_%H%M%S).log &	

	wait
		if [[ -e $CHILD_FAIL ]]
		then
			#a child process failed, abort mission
			echo "TX - One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> $EMAIL_MESSAGE
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
		echo "Run_Initialization.kjb failed in TXEB, review error log for additional detail." >> $EMAIL_MESSAGE
		mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
		cat $EMAIL_MESSAGE
		rm -f $INIT_OK
		#exit
		error_exit "$LINENO: An error has occurred."
	fi 
else
#mail here, it didn't work, no connectivity
echo "bpm_init_check.kjb failed in TXEB, review error log for additional detail." >> $EMAIL_MESSAGE
mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
cat $EMAIL_MESSAGE
error_exit "$LINENO: An error has occurred in TXEB. run_bpm.sh"
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
