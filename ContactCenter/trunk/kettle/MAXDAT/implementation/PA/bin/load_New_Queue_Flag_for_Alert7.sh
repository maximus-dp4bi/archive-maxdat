#!/bin/bash
. ~/.bash_profile
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
#PDI 7 - moved setenv to cronfile
#. $MAXDAT_ETL_PATH/PA/scripts/ContactCenter/implementation/PAEB/bin/set_env_vars.sh

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs/staging/Avaya
JOB=load_New_Queue_Flag_for_Alert
echo "maxdat_etl_path: $MAXDAT_ETL_PATH"
echo "jobs_dir: $JOBS_DIR"

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="CameronHill@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $JOB in ${ENV_CODE}"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo "log_dir: $LOG_DIR"
LOG_LEVEL="Detailed"

#PDI 7 - replaced call with run_kjb7.sh

#sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
$MAXDAT_ETL_PATH/run_kjb7.sh $JOBS_DIR/$JOB.kjb $KJB_LOG_LEVEL >> "$LOG_DIR/$JOB${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log"


rc=$?
if [[ $rc == 0 ]] ; then
   echo "$JOB process completed successfully at $(date +%Y%m%d_%H%M%S)."
else 
   echo "$JOB process failed with error code $rc.  See log files for details."
fi

