#!/bin/bash
. ~/.bash_profile
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/ContactCenter/trunk/kettle/MAXDAT/main/bin/load_Agent_First_Call_Dt.sh $
# $Revision: 10689 $
# $Date: 2016-08-26 10:02:52 -0700 (Fri, 26 Aug 2016) $
# $Author: lg74078 $
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
. $MAXDAT_ETL_PATH/FOLSOM/scripts/ContactCenter/implementation/FOLSOM/bin/set_env_vars.sh
# This program will run the Kettle job that executes adhoc jobs

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs/staging
#JOBS_DIR=/u01/maximus/maxdat-dev/FOLSOM/scripts/ContactCenter/main/jobs/staging
JOB=load_Agent_First_Call_Dt
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="LavanyaGopal@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
#LOG_DIR=/u01/maximus/maxdat-dev/FOLSOM/logs/ContactCenter
echo $LOG_DIR
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
