#!/bin/bash
. ~/.bash_profile
BASEDIR=$(dirname $0)
echo $BASEDIR

. $MAXDAT_ETL_PATH/ContactCenter/implementation/$STCODE/bin/set_env_vars.sh

# run_monitor_contact_center.sh
# This program will run the Kettle job to monitor the Contact Center data mart and report any data discrepancies in the CC_L_ERROR table

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs
JOB=execute_scheduled_monitor_contact_center
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL" >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"


#kitchen status codes
# 0     The job ran without a problem.
# 1     Errors occurred during processing
# 2     An unexpected error occurred during loading or running of the job
# 7     The job couldn't be loaded from XML or the Repository
# 8     Error loading steps or plugins (error in loading one of the plugins mostly)
# 9     Command line usage printing