#!/bin/ksh
. ~/.bash_profile

PATH=$KETTLE_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_HOME
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_45"
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"


$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/Load_NYEC_DMS_Lookups.kjb" -log="./Load_NYEC_DMS_Lookups_$(date +%Y%m%d_%H%M%S).LOG" -level="$DETAIL_LOG_LEVEL"

