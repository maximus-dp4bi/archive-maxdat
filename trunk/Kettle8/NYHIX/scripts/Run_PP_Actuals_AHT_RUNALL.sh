#!/bin/ksh
#. ~/.bash_profile

location='/u01/maximus/maxdat/NYHIX8/config'
source ${location}/.set_env

PATH=$KETTLE_NYHIX_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_NYHIX_HOME
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"


$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/${MODULE_PP}/Actuals_AHT_Staff_Hours/PP_Actuals_ATH_RUNALL.kjb" -log="$MAXDAT_ETL_LOGS/${MODULE_PP}/PP_Actuals_AHT_RUNALL$(date +%Y%m%d_%H%M%S).LOG" -level="$DETAIL_LOG_LEVEL"

