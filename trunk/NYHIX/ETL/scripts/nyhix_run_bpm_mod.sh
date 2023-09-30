#!/bin/ksh
. ~/.bash_profile
#nyhix_run_bpm.sh
PROGNAME=$(basename $0 .sh)
echo PROGNAME
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
PATH=$KETTLE_NYHIX_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
echo $PATH
export PATH
export KETTLE_HOME=$KETTLE_NYHIX_HOME
echo $KETTLE_HOME

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_45"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_PATH/$STCODE/ETL/scripts
echo $CUSTOM_DIR
LOG_DIR=$MAXDAT_ETL_PATH/$STCODE/ETL/logs
echo $LOG_DIR

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"

# Init_ok is also part of the run init chekc kjb job
INIT_OK="$CUSTOM_DIR/${STCODE}_run_init_check.txt"
echo $INIT_OK
CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"
echo $CHILD_FAIL


#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm.sh in $ENV_CODE"

rm -f $EMAIL_MESSAGE

#init check
#assumption that bpm_init_check.kjb and Run_Initiatization.kjb are present in $CUSTOM_DIR
$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $LOG_DIR/bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#creates ${STCODE}_run_init_check.txt
rc=$?
echo $rc

if [[ $rc != 0 ]] ; then
	rm -f $INIT_OK
	echo "exited with status: $rc - $STCODE bpm_Init_check.kjb, aborting run"  
	#>> $EMAIL_MESSAGE
	#mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	#cat $EMAIL_MESSAGE
	exit $rc
	
fi
echo "before if [[ $rc == 0 && -e $INIT_OK ]]"
if [[ $rc == 0 && -e $INIT_OK ]]
then
echo "calling Run_Initialization.kjb"
$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/Run_Initialization.kjb Run_Initialization  >> $LOG_DIR/Run_Initialization_$(date +%Y%m%d_%H%M%S).log
	if [[ $? -eq 0 ]]
	then 
	echo "calling ManageWork_RUNALL.kjb "
	#ensure the directory structure matches and the desired kjb/ktr files are specified
	$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ManageWork/ManageWork_RUNALL.kjb ManageWork_RUNALL >> $LOG_DIR/ManageWork_RUNALL_$(date +%Y%m%d_%H%M%S).log &

        $CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/MailFaxBatch/MailFaxBatch_RUNALL.kjb $DETAIL_LOG_LEVEL >> $LOG_DIR/MailFaxBatch_RUNALL_$(date +%Y%m%d_%H%M%S).log &

$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ProductionPlanning/PP_Actuals_RUNALL.kjb $DETAIL_LOG_LEVEL >> $LOG_DIR/PP_Actuals_RUNALL_$(date +%Y%m%d_%H%M%S).log &

	wait
		if [[ -e $CHILD_FAIL ]]
		then
			#a child process failed, abort mission
			echo "$STCODE - One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." #>> $EMAIL_MESSAGE
			#mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
			#cat $EMAIL_MESSAGE
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
		echo "Run_Initialization.kjb failed in $STCODE , review error log for additional detail." #>> $EMAIL_MESSAGE
		#mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
		#cat $EMAIL_MESSAGE
		rm -f $INIT_OK
		#exit
		error_exit "$LINENO: $STCODE - An Init error has occurred."
	fi 
else
#mail here, it didn't work, no connectivity
echo "bpm_init_check.kjb failed in $STCODE , review error log for additional detail." #>> $EMAIL_MESSAGE
#mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
#cat $EMAIL_MESSAGE
error_exit "$LINENO: An error has occurred in $STCODE . nyhix_run_bpm.sh"
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
