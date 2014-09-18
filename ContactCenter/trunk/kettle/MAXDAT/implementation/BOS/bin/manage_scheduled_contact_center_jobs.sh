#!/bin/bash
. ~/.bash_profile
source $BOS_SETENV
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/ContactCenter/trunk/kettle/MAXDAT/main/bin/manage_scheduled_contact_center_jobs.sh $
# $Revision: 10689 $
# $Date: 2014-07-02 14:33:13 -0400 (Wed, 02 Jul 2014) $
# $Author: jh44463 $
# This program will run the Kettle job that executes adhoc jobs

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs
JOB=manage_all_scheduled_jobs

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

