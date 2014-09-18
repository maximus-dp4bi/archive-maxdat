#!/bin/sh
. $NY_SETENV

LOG_LEVEL="Basic"
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/ProcessApp_NightlyUpdate.kjb" -log="$MAXDAT_ETL_LOGS/ProcessApp_NightlyUpdate.log" -level="$LOG_LEVEL" 

