#!/bin/bash
. ~/.profile


# This program will run the Kettle job necessary to run the one time agent fix

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/implementation/TXEB/jobs/One_time
JOB=one_time_load_update_agents
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo $LOG_DIR
LOG_LEVEL="Detailed"

ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
