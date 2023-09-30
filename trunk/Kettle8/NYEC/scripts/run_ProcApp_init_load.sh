#!/bin/sh
source /u01/maximus/maxdat/NYEC8/config/.set_env

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_DIR/$MODULE_PA/ProcessApp_Inital_Load.kjb" -log="$MAXDAT_LOG_DIR/$MODULE_PA/ProcessApp_Inital_Load.log" -level="$LOG_LEVEL" && $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_DIR/$MODULE_PA/ProcessApp_UpdateChangeDataCapture.kjb" -log="$MAXDAT_LOG_DIR/$MODULE_PA/ProcessApp_UpdateChangeDataCapture.log" -level="$LOG_LEVEL" &&  $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_DIR/$MODULE_PA/ProcessApp_BPM_Ins_Upd_Xfrm_Run.kjb" -log="$MAXDAT_LOG_DIR/$MODULE_PA/ProcessApp_BPM_Ins_Upd_Xfrm_Run.log" -level="$LOG_LEVEL"
