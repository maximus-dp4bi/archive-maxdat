#!/bin/sh
. /u01/maximus/maxdat/IL8/config/.set_env



$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_INIT/Pop_Case_ID_Step_Instance_Stg.kjb" -log="$MAXDAT_ETL_LOGS/$MODULE_INIT/Pop_Case_ID_Step_Instance_Stg.log" -level="$LOG_LEVEL"