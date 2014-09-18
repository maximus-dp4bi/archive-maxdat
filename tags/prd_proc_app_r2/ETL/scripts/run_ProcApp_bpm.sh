#!/bin/sh
. ~/.bash_profile

PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_DIR/ProcessApplication
LOG_DIR=$MAXDAT_LOG_DIR


LOG_LEVEL="Basic"

$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ProcessApp_InsertChangeDataCapture.kjb" -log="$LOG_DIR/ProcessApp_InsertChangeDataCapture.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ProcessApp_UpdateChangeDataCapture.kjb" -log="$LOG_DIR/ProcessApp_UpdateChangeDataCapture.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ProcessApp_BPM_Ins_Upd_Xfrm_Run.kjb" -log="$LOG_DIR/ProcessApp_BPM_Ins_Upd_Xfrm_Run.log" -level="$LOG_LEVEL"
