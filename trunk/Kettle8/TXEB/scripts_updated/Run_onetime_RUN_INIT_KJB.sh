#!/bin/ksh
. /dtxe4t/ETL_Scripts/scripts8/.set_env
#run_bpm.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/tx_run_bpm.sh $
# $Revision: 4462 $
# $Date: 2013-08-07 16:34:31 -0500 (Wed, 07 Aug 2013) $
# $Author: bt25944 $
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

export BPM_RUN_CHECK_FILE=tx_bmp_check.txt

#INIT_OK="$MAXDAT_ETL_PATH/tx_run_init_check.txt"
#CHILD_FAIL="/tmp/tx_child_task_fail.txt"

echo 'starting the ManageEnrl_Run_Initialization kjb now...'
ksh $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ManageEnrl_Run_Initialization.kjb Run_Initialization  >> $MAXDAT_ETL_LOGS/ManageEnrl_Run_Initialization_$(date +%Y%m%d_%H%M%S).log

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