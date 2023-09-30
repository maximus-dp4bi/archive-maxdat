#!/bin/sh
source /u01/maximus/maxdat/NYEC8/config/.set_env

#PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH

CUSTOM_DIR=$MAXDAT_ETL_DIR
LOG_DIR=$MAXDAT_LOG_DIR
LOG_LEVEL="Basic"

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$CUSTOM_DIR/maxdat_etl_maint_runall.kjb" -log="$LOG_DIR/maxdat_etl_maint_runall.log" -level="$LOG_LEVEL" 

