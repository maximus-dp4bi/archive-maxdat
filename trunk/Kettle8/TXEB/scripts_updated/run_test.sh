#!/bin/sh
. /dtxe4t/ETL_Scripts/scripts8/.set_env

#PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
#PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
#export KETTLE_HOME=$KETTLE_IL_HOME



CUSTOM_DIR=$MAXDAT_ETL_PATH
LOG_DIR=$MAXDAT_ETL_LOGS

#export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"

#SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
#CUSTOM_DIR=$MAXDAT_ETL_PATH/IL/ETL/scripts
#LOG_DIR=$MAXDAT_ETL_PATH/IL/ETL/logs
#LOG_LEVEL="Basic"

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$CUSTOM_DIR/bpm_Init_check.kjb" -level="$DETAIL_LOG_LEVEL"  >> $LOG_DIR/tx_bpm_init_check_$(date +%Y%m%d_%H%M%S).log