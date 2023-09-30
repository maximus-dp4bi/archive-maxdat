#!/bin/bash
. /u01/maximus/maxdat/IL8/config/.set_env


$MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_PATH/$MODULE_PI/Subprogram_type_Upd_MMC_added.ktr" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/$MODULE_PI/PI_ONETIME_Subprogram_type_MMC_$(date +%Y%m%d_%H%M%S).log

