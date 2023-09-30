#!/bin/bash
. ~/.profile

# run_tx_log_diagnostics.sh
# This program will run the Kettle transform to log the JVM options

TRANSFORMS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/transforms/utility
TRANSFORM=log_diagnostics
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
LOG_LEVEL=$DETAIL_LOG_LEVEL

ksh $MAXDAT_KETTLE_DIR/pan.sh -file="$TRANSFORMS_DIR/$TRANSFORM.ktr" -level="$LOG_LEVEL" >> "$LOG_DIR/$TRANSFORM$(date +%Y%m%d_%H%M%S).log"


#kitchen status codes
# 0     The job ran without a problem.
# 1     Errors occurred during processing
# 2     An unexpected error occurred during loading or running of the job
# 7     The job couldn't be loaded from XML or the Repository
# 8     Error loading steps or plugins (error in loading one of the plugins mostly)
# 9     Command line usage printing
