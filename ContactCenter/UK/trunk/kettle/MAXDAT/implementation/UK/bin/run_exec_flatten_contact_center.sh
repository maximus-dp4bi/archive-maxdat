#!/bin/bash
. ~/.bash_profile
source $BOS_SETENV
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/ContactCenter/trunk/kettle/MAXDAT/main/bin/run_exec_flatten_contact_center.sh$
# $Revision$
# $Date$
# $Author$
# This program will run the Kettle job that executes adhoc jobs

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs
JOB=execute_flatten_project_facts

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

#cron example run flatten job at 17:05
#05 17 * * * /u01/maximus/maxdat-uat/NYHIX/ETL/scripts/ContactCenter/main/bin/run_exec_flatten_contact_center.sh > /u01/maximus/maxdat-uat/NYHIX/ETL/logs/ContactCenter/`uname -n`_contcent.log 2>&1

#kitchen status codes
# 0     The job ran without a problem.
# 1     Errors occurred during processing
# 2     An unexpected error occurred during loading or running of the job
# 7     The job couldn't be loaded from XML or the Repository
# 8     Error loading steps or plugins (error in loading one of the plugins mostly)
# 9     Command line usage printing
