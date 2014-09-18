#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR

. $BASEDIR/set_env_vars.sh

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs
JOB=execute_flatten_project_facts
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="JeromeHampson@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo"Logging to:  $LOG_DIR"
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL" >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
#cron example run flatten job at 17:05
#05 17 * * * /u01/maximus/maxdat-uat/NYHIX/ETL/scripts/ContactCenter/main/bin/run_flatten_contact_center.sh > /u01/maximus/maxdat-uat/NYHIX/ETL/logs/ContactCenter/`uname -n`_contcent.log 2>&1

#kitchen status codes
# 0     The job ran without a problem.
# 1     Errors occurred during processing
# 2     An unexpected error occurred during loading or running of the job
# 7     The job couldn't be loaded from XML or the Repository
# 8     Error loading steps or plugins (error in loading one of the plugins mostly)
# 9     Command line usage printing
