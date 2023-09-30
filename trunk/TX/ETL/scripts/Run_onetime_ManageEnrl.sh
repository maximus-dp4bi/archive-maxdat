#!/bin/ksh
. ~/.profile
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

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
#INIT_OK="$MAXDAT_ETL_PATH/tx_run_init_check.txt"
#CHILD_FAIL="/tmp/tx_child_task_fail.txt"

ECHO starting the ProcessManageEnroll_RUNALL_INTIAL_RUN kjb now...                                                                                   
ksh $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ManageEnrollmentActivity/ProcessManageEnroll_RUNALL_INTIAL_RUN.kjb Run_Initialization  >> $MAXDAT_ETL_LOGS/ProcessManageEnroll_RUNALL_INTIAL_RUN_$(date +%Y%m%d_%H%M%S).log
