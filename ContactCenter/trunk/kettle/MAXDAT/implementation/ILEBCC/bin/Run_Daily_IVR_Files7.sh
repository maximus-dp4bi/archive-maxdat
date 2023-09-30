#!/bin/bash
#. ~/.bash_profile
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

BASEDIR=$(dirname $0)
echo $BASEDIR
#. $MAXDAT_ETL_PATH/ILEBCC/scripts/ContactCenter/implementation/ILEBCC/bin/set_env_vars.sh
# This program will run the Kettle job that executes adhoc jobs

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"
JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/implementation/ILEBCC/jobs/IVR
JOB=download_daily_IVR_files_csv
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
#EMAIL="CameronHill@maximus.com"
export EMAIL_MESSAGE="/tmp/${STCODE}_${JOB}${PDI_VERSION}_ERROR_LOG.log"
export EMAIL_SUBJECT="Errors with $STCODE $JOB in $ENV_CODE"
#remove previous error files
rm -f $EMAIL_MESSAGE $CHILD_FAIL

RUN_KJB_DIR=/u01/maximus/maxdat-$ENV_CODE/IL/ETL/scripts

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo $LOG_DIR
LOG_LEVEL="Detailed"
#using run_kjb7 as part of PDI 7 upgrade
#sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

$RUN_KJB_DIR/run_kjb7.sh $JOBS_DIR/$JOB.kjb $KJB_LOG_LEVEL >> "$LOG_DIR/$JOB${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log"

rc=$?
if [[ $rc == 0 ]] ; then
   echo "$JOB process completed successfully at $(date +%Y%m%d_%H%M%S)."
else 
   echo "$JOB process failed with error code $rc.  See log files for details."
fi
