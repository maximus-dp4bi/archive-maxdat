#!/bin/ksh
. ~/.bash_profile
. $MAXDAT_ETL_PATH/.setenv_var.sh
#nyhix_run_planning.sh
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
	exit 1
}

export KETTLE_HOME=$KETTLE_NYHIX_HOME

KTR_LOG_LEVEL='Basic'
KJB_LOG_LEVEL='Detailed'

# PLANNING_OK is also part of the run init check kjb job
PLANNING_OK="$MAXDAT_ETL_PATH/${STCODE}_run_planning_check.txt"
PLANNING_FAIL="$MAXDAT_ETL_PATH/${STCODE}_child_planning_fail.txt"

#mail related variables
EMAIL='MAXDatSystem@maximus.com'
EMAIL_MESSAGE="/tmp/${2}_${STCODE}-ERROR-LOG.txt"
EMAIL_SUBJECT="${STCODE}-Errors With $2"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $PLANNING_OK ]] ; then
   echo "Run Aborted - $PLANNING_OK exists"
   exit;
else
   echo "Starting ${STCODE}_run_planning.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $PLANNING_FAIL
   touch $PLANNING_OK
fi

#init check
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/Planning_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/Planning_Init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
	echo "Exited with status: $rc - ${STCODE} Planning_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
	rm -f $PLANNING_OK
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
else
   $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProductionPlanning/PP_Forecast_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/PP_Forecast_RUNALL_$(date +%Y%m%d_%H%M%S).log &
   wait
   $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProductionPlanning/PP_Actuals_Import_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/PP_Actuals_Import_RUNALL_$(date +%Y%m%d_%H%M%S).log &
   wait
   if [[ -e $PLANNING_FAIL ]]
	then
		#a child process failed, abort mission
		echo "$STCODE - One or more Planning subtasks failed.  Check error logs and $PLANNING_FAIL for more details." >> $EMAIL_MESSAGE
		rm -f $PLANNING_OK
		mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
		cat $EMAIL_MESSAGE
		#exit
		error_exit "$LINENO: $STCODE - A Child Planning error has occurred."
	else
		#success, move on
		echo "$STCODE - Child Planning processes completed successfully."
		rm -f $PLANNING_OK
		exit 0
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
