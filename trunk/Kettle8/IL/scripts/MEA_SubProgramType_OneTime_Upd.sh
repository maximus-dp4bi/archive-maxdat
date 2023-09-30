#!/bin/bash
. /u01/maximus/maxdat/IL8/config/.set_env


$MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_PATH/$MODULE_MEA/ManageEnroll_ONETIME_Subprogram_type.ktr" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/$MODULE_MEA/ManageEnroll_ONETIME_Subprogram_type_$(date +%Y%m%d_%H%M%S).log

