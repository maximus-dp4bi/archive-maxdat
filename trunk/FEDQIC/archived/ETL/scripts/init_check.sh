#!/bin/bash
. ~/.bash_profile
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/FEDQIC/ETL/scripts/init_check.sh $
# $Revision: 21608 $
# $Date: 2017-10-27 11:11:41 -0400 (Fri, 27 Oct 2017) $
# $Author: ch136904 $
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
. /u01/maximus/maxdat-uat/FEDQIC/scripts/.set_env
# This program will run the Kettle job that executes adhoc jobs

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$MAXDAT_ETL_PATH
JOB=init_check
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR
ERR_DIR="/tmp"

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="CameronHill@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/${STCODE}_INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with ${STCODE}_$JOB"

LOG_DIR=$MAXDAT_ETL_LOGS
echo $LOG_DIR
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
