#!/bin/bash
. ~/.bash_profile
source $MD_SETENV
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$
# This program will run the Kettle job that executes adhoc jobs

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs
JOB=manage_all_scheduled_jobs

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

