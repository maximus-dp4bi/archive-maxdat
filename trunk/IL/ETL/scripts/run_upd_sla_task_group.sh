#!/bin/sh
. ~/.bash_profile

#PATH=/u01/maximus/maxdat-dev/IL/config/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
#export KETTLE_HOME=/u01/maximus/maxdat-dev/IL/config
PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"

SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_PATH/IL/ETL/scripts
LOG_DIR=$MAXDAT_ETL_PATH/IL/ETL/logs
ERR_DIR=$MAXDAT_ETL_PATH/IL/ETL/errors
BASIC_LOG_LEVEL="Basic"

$SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/UPD_SLA_Task_Groups_v2.ktr" -log="$LOG_DIR/UPD_SLA_Task_Groups_v2.log" -level="$BASIC_LOG_LEVEL" 

