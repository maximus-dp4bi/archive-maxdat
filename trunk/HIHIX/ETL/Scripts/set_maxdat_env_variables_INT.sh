#!/bin/sh
. ~/.bash_profile

KETTLE_HCCHIX_HOME="/u01/maximus/maxdat-int/HCCHIX/config"
PATH=$KETTLE_HCCHIX_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH

export PATH
export KETTLE_HOME=$KETTLE_HCCHIX_HOME
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_45"
#
export MAXDAT_ETL_PATH="/u01/maximus/maxdat-int/HCCHIX/ETL/scripts"
export MAXDAT_ETL_LOGS="/u01/maximus/maxdat-int/HCCHIX/ETL/logs"
#
export MAXDAT_ETL_DIR="/u01/maximus/maxdat-int/HCCHIX/ETL/scripts"
export MAXDAT_LOG_DIR="/u01/maximus/maxdat-int/HCCHIX/ETL/logs"



