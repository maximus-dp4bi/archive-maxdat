#!/bin/ksh
. /u01/maximus/maxdat/IL8/config/.set_env


$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_INIT/PP_WFM_RUNALL.kjb" -log="$MAXDAT_ETL_LOGS/$MODULE_INIT/PP_WFM_RUNALL_$(date +%Y%m%d_%H%M%S).LOG" -level="$DETAIL_LOG_LEVEL"

