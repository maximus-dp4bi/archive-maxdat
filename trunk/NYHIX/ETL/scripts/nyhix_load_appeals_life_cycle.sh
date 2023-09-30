#!/bin/ksh
. ~/.bash_profile

export PATH=$KETTLE_NYHIX_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export KETTLE_HOME=$KETTLE_NYHIX_HOME
export DETAIL_LOG_LEVEL="Detailed"

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/Load_appeals_life_cycle.kjb" -log="$MAXDAT_ETL_LOGS/Load_appeals_life_cycle_$(date +%Y%m%d_%H%M%S).log" -level="$DETAIL_LOG_LEVEL"
