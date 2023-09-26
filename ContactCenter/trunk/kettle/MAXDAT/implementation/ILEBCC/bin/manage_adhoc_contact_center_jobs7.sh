#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# This program will run the Kettle job that executes adhoc jobs
# ================================================================================

PROGNAME=$(basename $0 .sh)

BASEDIR=$(dirname $0)
echo $BASEDIR

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0) at $(date +%Y%m%d_%H%M%S)."

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs
echo $JOBS_DIR

JOB=manage_all_adhoc_jobs.kjb
echo $JOB

RUN_KJB_DIR=/u01/maximus/maxdat-$ENV_CODE/IL/ETL/scripts
echo $RUN_KJB_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="nickvirdi@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo $LOG_DIR
LOG_FILE="$LOG_DIR/$JOB${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log"

echo "Starting manage_all_adhoc_jobs"
$RUN_KJB_DIR/run_kjb7.sh $JOBS_DIR/$JOB $KJB_LOG_LEVEL >> $LOG_DIR/manage_all_adhoc_jobs${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log
