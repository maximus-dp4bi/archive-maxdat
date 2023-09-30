#!/bin/sh
source /u01/maximus/maxdat/NYEC8/config/.set_env


$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_DIR/$MODULE_INIT/EventFiller.kjb" -log="$MAXDAT_LOG_DIR/$MODULE_INIT/EventFillerInitialload.log" -level="$LOG_LEVEL" 


