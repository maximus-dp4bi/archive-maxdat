#!/bin/sh

PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH

SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR="/u01/maximus/maxbi-uat/ETL/scripts"
LOG_DIR="/u01/maximus/maxbi-uat/ETL/logs"
LOG_LEVEL="Basic"

$SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ProccessApp_InitLoad_StepInstanceStg_1.ktr" -log="$LOG_DIR/ProccessApp_InitLoad_StepInstanceStg_1.log" -level="$LOG_LEVEL" 

