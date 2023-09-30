#!/bin/ksh
. ~/.bash_profile
. $MAXDAT_ETL_PATH/.setenv_var.sh
PATH=$KETTLE_NYHIX_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_NYHIX_HOME
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"


$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/ProductionPlanning/Actuals_AHT_Staff_Hours/PP_Actuals_ATH_RUNALL.kjb" -log="$MAXDAT_ETL_LOGS/PP_Actuals_AHT_RUNALL$(date +%Y%m%d_%H%M%S).LOG" -level="$DETAIL_LOG_LEVEL"

