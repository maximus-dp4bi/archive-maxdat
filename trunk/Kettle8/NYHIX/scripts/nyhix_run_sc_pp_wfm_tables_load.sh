#!/bin/ksh
#. ~/.bash_profile
#nyhix_run_dp_scorecard.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/NYHIX/ETL/scripts/nyhix_run_sc_pp_wfm_tables_load.sh $
# $Revision: 19682 $
# $Date: 2017-04-14 09:09:27 -0700 (Fri, 14 Apr 2017) $
# $Author: gt83345 $
PROGNAME=$(basename $0 .sh)

location='/u01/maximus/maxdat/NYHIX8/config'
source ${location}/.set_env

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
INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_sc_pp_wfm_tables_check.txt"
CHILD_FAIL="/tmp/${STCODE}_sc_pp_wfm_tables_child_task_fail.txt"


#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_sc_pp_wfm_tables-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_sc_pp_wfm_tables.sh in $ENV_CODE"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   exit;
else
   echo "Starting ${STCODE}_run_sc_pp_wfm_tables.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_OK
fi

#init check
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/${MODULE_INIT}/dp_scorecard_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/${MODULE_INIT}/dp_scorecard_init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - DP_Scorecard_Init_check.kjb, aborting run in $STCODE" >> $EMAIL_MESSAGE
	rm -f $INIT_OK
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
else
	#ensure the directory structure matches and the desired kjb/ktr files are specified
	$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/${MODULE_DPSC}/Load_PP_WFM_Tables.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/${MODULE_DPSC}/Load_PP_WFM_Tables_$(date +%Y%m%d_%H%M%S).log &
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
