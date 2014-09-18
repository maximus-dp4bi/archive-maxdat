#!/bin/sh
. ~/.bash_profile

#PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"

SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_PATH/IL/ETL/scripts
LOG_DIR=$MAXDAT_ETL_PATH/IL/ETL/logs
LOG_LEVEL="Basic"

$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ProcessLetter_Fix1188.kjb" -log="$LOG_DIR/ProcessLetter_Fix1188.log" -level="$LOG_LEVEL" 