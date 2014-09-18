#!/bin/sh
. ~/.bash_profile

PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH

SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_DIR/ProcessApplication
LOG_DIR=$MAXDAT_LOG_DIR
LOG_LEVEL="Basic"

$SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ProccessApp_InitLoad_StepInstanceStg_1.ktr" -log="$LOG_DIR/ProccessApp_InitLoad_StepInstanceStg_1.log" -level="$LOG_LEVEL" 

