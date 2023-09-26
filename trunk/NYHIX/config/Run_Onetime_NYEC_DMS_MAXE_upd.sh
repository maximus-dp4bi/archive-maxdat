#!/bin/ksh
# . ~/.bash_profile

PATH=/u01/maximus/maxdat-uat/NYHIX/config/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_HOME
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_45"
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"


/u01/app/appadmin/product/pentaho/data-integration/kitchen.sh -file="/u01/maximus/maxdat-uat/NYHIX/ETL/scripts/Load_NYEC_DMS_Lookups.kjb" -log="/u01/maximus/maxdat-uat/NYHIX/ETL/Load_NYEC_DMS_Lookups_$(date +%Y%m%d_%H%M%S).LOG" -level="$DETAIL_LOG_LEVEL"

