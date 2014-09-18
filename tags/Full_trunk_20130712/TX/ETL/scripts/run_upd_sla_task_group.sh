#!/bin/ksh
#. ~/.bash_profile
. ~/.profile
#PATH=/u01/maximus/maxdat-dev/IL/config/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
#export KETTLE_HOME=/u01/maximus/maxdat-dev/IL/config
PATH=/u25/app/product/kettle/4.2/data-integration/.kettle/kettle.properties:.:/u25/app/product/kettle/4.2/data-integration/:$PATH
export PATH


export PENTAHO_JAVA_HOME="/u25/app/product/java/j6sdk"

SCRIPTS_DIR="/u25/app/product/kettle/4.2/data-integration"
CUSTOM_DIR=/u25/ETL_Scripts/DEV/scripts
LOG_DIR=/u25/ETL_Logs/DEV
ERR_DIR=/u25/ETL_Logs/DEV/errors
BASIC_LOG_LEVEL="Basic"

ksh $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/UPD_SLA_Task_Groups_v2.ktr" -log="$LOG_DIR/UPD_SLA_Task_Groups_v2.log" -level="$BASIC_LOG_LEVEL" 

