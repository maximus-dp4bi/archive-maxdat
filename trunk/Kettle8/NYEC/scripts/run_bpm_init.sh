#!/bin/sh
source /u01/maximus/maxdat/NYEC8/config/.set_env



$SCRIPTS_DIR/kitchen.sh -file="$MAXDAT_ETL_DIR/Run_Initialization.kjb" -log="$MAXDAT_LOG_DIR/$MODULE_INIT/Run_Initialization.log" -level="$LOG_LEVEL" 

