#!/bin/sh
. /u01/maximus/maxdat/IL8/config/.set_env

                                                                                                   
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_MEA/ProcessManageEnroll_RUNALL_INTIAL_RUN_Partial.kjb" -log="$MAXDAT_ETL_LOGS/$MODULE_MEA/ProcessManageEnroll_RUNALL_INTIAL_RUN_Partial.log" -level="$DETAIL_LOG_LEVEL"
