#!/bin/ksh
. /u01/maximus/maxdat/IL8/config/.set_env


$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_AT/onetime/Onetime_Load_task.kjb" -log="$MAXDAT_ETL_LOGS/$MODULE_AT/Onetime_Load_task$(date +%Y%m%d_%H%M%S).LOG" -level="$DETAIL_LOG_LEVEL"

