#!/bin/sh
source /u01/maximus/maxdat/NYEC8/config/.set_env

$MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_DIR/$MODULE_PA/ProccessApp_InitLoad_StepInstanceStg_1.ktr" -log="$MAXDAT_LOG_DIR/$MODULE_PA/ProccessApp_InitLoad_StepInstanceStg_1.log" -level="$LOG_LEVEL" 

