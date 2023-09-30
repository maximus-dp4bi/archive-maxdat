#!/bin/sh
source /u01/maximus/maxdat/NYEC8/config/.set_env


$SCRIPTS_DIR/kitchen.sh -file="MAXDAT_ETL_PATH/$MODULE_MW/BPM_EVENT_CONV_QUEUE_UPD.kjb" -log="MAXDAT_LOG_DIR/$MODULE_MW/BpmUpdateEventConv.log" -level="$LOG_LEVEL"
