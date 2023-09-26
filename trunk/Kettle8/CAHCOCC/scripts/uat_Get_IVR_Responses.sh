#!/bin/bash
#. ~/.bash_profile
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/CAHCOCC/scripts/Get_IVR_Responses.sh $
# $Revision: 28677 $
# $Date: 2020-01-13 16:21:52 -0800 (Mon, 13 Jan 2020) $
# $Author: aa24065 $
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

BASEDIR=$(dirname $0)
echo $BASEDIR
#. $MAXDAT_ETL_PATH/CAHCO/ETL/scripts/set_env_vars.sh

export MD_SETENV=/u01/maximus/maxdat-uat/CAHCO8/scripts/.set_env
. $MD_SETENV
# This program will run the Kettle job that executes adhoc jobs

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$MAXDAT_ETL_PATH
JOB=Get_IVR_Responses
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

LOG_DIR=$MAXDAT_ETL_LOGS
echo $LOG_DIR
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
