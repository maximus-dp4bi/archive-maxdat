#!/bin/$
# pa_run_instance_load8.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/PAIEB/ETL/scripts/pa_run_instance_load8.sh $
# $Revision: 30782 $
# $Date: 2020-09-10 15:01:17 -0500 (Thu, 10 Sep 2020) $
# $Author: ss153729 $
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
#	rm -f $INIT_OK
	exit 1
}
function get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}
#
SCRIPTDIR="$(get_script_dir)"
. $SCRIPTDIR/.set_env8.sh
#
#
# Echo Environment Variables
echo "STCODE=$STCODE"
echo "MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH"
echo "MAXDAT_ETL_LOGS=$MAXDAT_ETL_LOGS"
echo "ENV_CODE=$ENV_CODE"
#
#export KETTLE_HOME=$KETTLE_NYHIX_HOME
#
KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
KJB_LOG_ROWLEVEL="Rowlevel"
INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_instance_check.txt"
INIT_BPM_OK="$MAXDAT_ETL_PATH/${STCODE}_run_check.txt"
CHILD_FAIL="/tmp/${STCODE}_child_task_instance_fail.txt"
CHILD_BPM_FAIL="/tmp/${STCODE}_child_task_fail.txt"
#
#
#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_run_instance_load-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_instance_check.sh in $ENV_CODE"
EMAIL_BPM_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
#
#checking for run file, Abort if it exists, create if it does not exists
#if [[ -e $INIT_BPM_OK ]] ; then
#   echo "Run Aborted - $INIT_OK exists"
#   exit;
#else
#   rm -f $EMAIL_BPM_MESSAGE $CHILD_BPM_FAIL
#fi
#
#if [[ -e $INIT_OK ]] ; then
#   echo "Run Aborted - $INIT_OK exists"
#   exit;
#else
#   echo "Starting ${STCODE}_run_instance_load.sh in ${ENV_CODE}."
#   rm -f $EMAIL_MESSAGE $CHILD_FAIL
#   touch $INIT_OK
#fi

#init check
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/bpm_init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - BPM_Init_check.kjb, aborting run in $STCODE" >> $EMAIL_MESSAGE
#	rm -f $INIT_OK
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
else
   	#ensure the directory structure matches and the desired kjb/ktr files are specified
	$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MW/MW_Populate_Instance_Tables.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/MW_Populate_Instance_Tables_$(date +%Y%m%d_%H%M%S).log &
	wait
        if [[ -e $CHILD_FAIL ]]
		then
			#a child process failed, abort mission
			echo "$STCODE - One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> $EMAIL_MESSAGE
			mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
			cat $EMAIL_MESSAGE
#			rm -f $INIT_OK
			#exit
			error_exit "$LINENO: $STCODE - A Child error has occurred."
		else
 	                
	                $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProductionPlanning/Actuals_v3/PP_Actuals_Process.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/PP_Actuals_Process_$(date +%Y%m%d_%H%M%S).log &
                        wait
		        if [[ -e $CHILD_FAIL ]]
		        then
			    #a child process failed, abort mission
			    echo "$STCODE - One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> $EMAIL_MESSAGE
			    mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
			    cat $EMAIL_MESSAGE
#			    rm -f $INIT_OK
			    #exit
			    error_exit "$LINENO: $STCODE - A Child error has occurred."
		        else
			    #success, move on
			    echo "$STCODE - Child processes completed successfully."
#			    rm -f $INIT_OK
			    exit 0
		        fi	
             fi
fi
#
#pan status codes
# 0 	The transformation ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading / running of the transformation
# 3 	Unable to prepare and initialize this transformation
# 7 	The transformation couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing
#
#kitchen status codes
# 0 	The job ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading or running of the job
# 7 	The job couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing
