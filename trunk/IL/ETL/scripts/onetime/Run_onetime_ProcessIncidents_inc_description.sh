!/bin/sh
. ~/.bash_profile

PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_PATH/IL/ETL/scripts
LOG_DIR=$MAXDAT_ETL_PATH/IL/ETL/logs
ERR_DIR=$MAXDAT_ETL_PATH/IL/ETL/errors
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"


$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ProcessIncidents/Process_incident_upd_inc_description_one_time.kjb" -log="$LOG_DIR/Process_incident_upd_inc_description_one_time.LOG" -level="$DETAIL_LOG_LEVEL"

