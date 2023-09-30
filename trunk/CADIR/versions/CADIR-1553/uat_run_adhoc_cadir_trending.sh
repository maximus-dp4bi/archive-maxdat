#!/bin/bash
export MD_SETENV=/u01/maximus/maxdat-uat/CADIR/scripts/.set_env
. $MD_SETENV

JOBS_DIR=$MAXDAT_ETL_PATH
JOB=adhoc_CA_TREND_CALC
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -log="$MAXDAT_ETL_LOGS/$JOB$(date +%Y%m%d_%H%M%S).log" -level="$KJB_LOG_LEVEL"
