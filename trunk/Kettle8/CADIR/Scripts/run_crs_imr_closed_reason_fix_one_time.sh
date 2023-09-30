#!/bin/bash
source $MD_SETENV


JOBS_DIR=$MAXDAT_ETL_PATH
JOB=CRS_IMR_Closed_Reason_Fix_One_Time
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -log="$MAXDAT_ETL_LOGS/$JOB$(date +%Y%m%d_%H%M%S).log" -level="$KJB_LOG_LEVEL"
