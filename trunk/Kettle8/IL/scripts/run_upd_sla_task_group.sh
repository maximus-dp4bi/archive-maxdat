#!/bin/sh
. /u01/maximus/maxdat/IL8/config/.set_env


$MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_PATH/$MODULE_INIT/UPD_SLA_Task_Groups_v2.ktr" -log="$MAXDAT_ETL_LOGS/$MODULE_INIT/UPD_SLA_Task_Groups_v2.log" -level="$LOG_LEVEL" 

