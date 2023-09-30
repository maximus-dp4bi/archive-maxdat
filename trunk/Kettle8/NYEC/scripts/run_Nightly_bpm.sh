#!/bin/sh
source /u01/maximus/maxdat/NYEC8/config/.set_env

#PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_PA/ProcessApp_NightlyUpdate.kjb" -log="$MAXDAT_LOG_DIR/$MODULE_PA/ProcessApp_NightlyUpdate.log" -level="$LOG_LEVEL" 

