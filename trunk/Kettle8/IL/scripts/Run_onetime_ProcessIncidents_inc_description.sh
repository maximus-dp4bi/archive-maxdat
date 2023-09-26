#!/bin/bash
. /u01/maximus/maxdat/IL8/config/.set_env


$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_PI/Process_incident_upd_inc_description_one_time.kjb" -log="$MAXDAT_ETL_LOGS/$MODULE_PI/Process_incident_upd_inc_description_one_time.LOG" -level="$DETAIL_LOG_LEVEL"

