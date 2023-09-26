#!/bin/ksh
. ~/.bash_profile
#nyhix_run_dp_scorecard.sh
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
INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_dp_scorecard_check.txt"
CHILD_FAIL="/tmp/${STCODE}_dp_scorecard_child_task_fail.txt"


#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_dp_scorecard-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_dp_scorecard.sh in $ENV_CODE"

#checking for run file, Abort if it exists, create if it does not exists

	$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/ProcessLetters/Backfill_Manual_Notice_Type.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/Backfill_Manual_Notice_Type_$(date +%Y%m%d_%H%M%S).log &

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
