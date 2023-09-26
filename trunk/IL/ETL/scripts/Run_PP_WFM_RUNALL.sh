#!/bin/ksh
. ~/.bash_profile

PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME
export STCODE=IL
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/ETL/logs
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"


$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/IL/ETL/scripts/PP_WFM_RUNALL.kjb" -log="$MAXDAT_ETL_LOGS/PP_WFM_RUNALL_$(date +%Y%m%d_%H%M%S).LOG" -level="$DETAIL_LOG_LEVEL"

