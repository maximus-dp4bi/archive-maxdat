#!/bin/sh

PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH

SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR="/u01/maximus/maxbi-uat/ETL/scripts"
LOG_DIR="/u01/maximus/maxbi-uat/ETL/logs"
LOG_LEVEL="Basic"

$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/Run_Initiatization.kjb" -log="$LOG_DIR/Run_Initiatization.log" -level="$LOG_LEVEL" 

