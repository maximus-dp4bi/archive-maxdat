#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR

. $BASEDIR/set_env_vars.sh

# run_flatten_contact_center.sh
# This program will run the Kettle job to flatten the Contact Center data mart to .csv files

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs/monitoring
JOB=monitor_Pipkins
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

# dates in format yyyy-mm-dd hh:mm:ss
STARTDATE=$1
ENDDATE=$2

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL" -param:startDateTime=$STARTDATE -param:endDateTime=$ENDDATE >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"


#kitchen status codes
# 0     The job ran without a problem.
# 1     Errors occurred during processing
# 2     An unexpected error occurred during loading or running of the job
# 7     The job couldn't be loaded from XML or the Repository
# 8     Error loading steps or plugins (error in loading one of the plugins mostly)
# 9     Command line usage printing