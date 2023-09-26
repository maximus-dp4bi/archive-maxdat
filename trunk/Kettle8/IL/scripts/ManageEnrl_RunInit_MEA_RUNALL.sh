#!/bin/sh
. /u01/maximus/maxdat/IL8/config/.set_env


                                                                                                   
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_INIT/ManageEnrl_Run_Initialization.kjb" -log="$MAXDAT_ETL_LOGS/$MODULE_INIT/ManageEnrl_Run_Initialization.log" -level="$DETAIL_LOG_LEVEL"
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_MEA/ProcessManageEnroll_RUNALL.kjb" -log="$MAXDAT_ETL_LOGS/$MODULE_MEA/ProcessManageEnroll_RUNALL.kjb" -level="$DETAIL_LOG_LEVEL"
