#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
#   SVN_FILE_URL := '$URL$'; 
#   SVN_REVISION := '$Revision$'; 
#   SVN_REVISION_DATE := '$Date$'; 
#   SVN_REVISION_AUTHOR := '$Author$';
# ================================================================================


#. ~/.bash_profile
BASEDIR=$(dirname $0)
echo $BASEDIR
. /u01/maximus/maxdat-prd/ILEBCC8/scripts/ContactCenter/implementation/ILEBCC/bin/.set_env

# run_monitor_contact_center.sh
# This program will run the Kettle job to monitor the Contact Center data mart and report any data discrepancies in the CC_L_ERROR table

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs/monitoring
JOB=monitor_contact_center
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

# dates in format "yyyy-mm-dd hh:mm:ss"
STARTDATE=$1
ENDDATE=$2

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
STCODE=${STCODE^}
ENV_CODE=${ENV_CODE^^}
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="$JOBS_DIR/$(basename $0)_ERROR_LOG"
EMAIL_SUBJECT="$STCODE $ENV_CODE - Errors with $STCODE_$(basename $0)"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL" -param:startDateTime=$STARTDATE -param:endDateTime=$ENDDATE >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
rc=$?
if [[ $rc != 0 ]] ; then
	echo "Exited with status: $rc - $(basename $0), aborting run in $STCODE $ENV_CODE"  > $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
fi

#kitchen status codes
# 0     The job ran without a problem.
# 1     Errors occurred during processing
# 2     An unexpected error occurred during loading or running of the job
# 7     The job couldn't be loaded from XML or the Repository
# 8     Error loading steps or plugins (error in loading one of the plugins mostly)
# 9     Command line usage printing