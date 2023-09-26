#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
#   SVN_FILE_URL := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/ILEBCC/scripts/ContactCenter/main/bin/dev/manage_adhoc_contact_center_jobs.sh $'; 
#   SVN_REVISION := '$Revision: 31543 $'; 
#   SVN_REVISION_DATE := '$Date: 2021-02-11 12:31:28 -0600 (Thu, 11 Feb 2021) $'; 
#   SVN_REVISION_AUTHOR := '$Author: sm152167 $';
# ================================================================================


. /u01/maximus/maxdat-uat/ILEBCC8/scripts/ContactCenter/implementation/ILEBCC/bin/.set_env

#. ~/.bash_profile
# This program will run the Kettle job that executes adhoc jobs
PROGNAME=$(basename $0 .sh)

BASEDIR=$(dirname $0)
echo $BASEDIR

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0) at $(date +%Y%m%d_%H%M%S)."

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs
JOB=manage_all_adhoc_jobs
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
STCODE=${STCODE^}
ENV_CODE=${ENV_CODE^^}
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="$JOBS_DIR/$(basename $0)_ERROR_LOG"
EMAIL_SUBJECT="$STCODE $ENV_CODE - Errors with $STCODE_$(basename $0)"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo $LOG_DIR
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
rc=$?
if [[ $rc != 0 ]] ; then
	echo "Exited with status: $rc - $(basename $0), aborting run in $STCODE $ENV_CODE"  > $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
fi