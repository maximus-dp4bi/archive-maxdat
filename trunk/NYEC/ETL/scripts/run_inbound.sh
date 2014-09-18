#!/bin/sh
. ./.set_env

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/ManageInbound_Job_Start.kjb" -log="$MAXDAT_ETL_LOGS/ManageInbound_Job_Start.log" -level="$KJB_LOG_LEVEL"
