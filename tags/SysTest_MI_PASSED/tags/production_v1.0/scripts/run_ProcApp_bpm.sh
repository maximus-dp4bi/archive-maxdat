#!/bin/sh

PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH

SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR="/u01/maximus/maxbi-uat/ETL/scripts"
LOG_DIR="/u01/maximus/maxbi-uat/ETL/logs"
LOG_LEVEL="Basic"

$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ProcessApp_InsertChangeDataCapture.kjb" -log="$LOG_DIR/ProcessApp_InsertChangeDataCapture.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ProcessApp_UpdateChangeDataCapture.kjb" -log="$LOG_DIR/ProcessApp_UpdateChangeDataCapture.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ProcessApp_BPM_Ins_Upd_Xfrm_Run.kjb" -log="$LOG_DIR/ProcessApp_BPM_Ins_Upd_Xfrm_Run.log" -level="$LOG_LEVEL"
