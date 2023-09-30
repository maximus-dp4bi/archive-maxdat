#!/bin/sh
. ~/.bash_profile

PATH=$KETTLE_NY_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_NY_HOME

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=/u01/maximus/maxbi-uat/ETL/scripts
LOG_DIR=/u01/maximus/maxbi-uat/ETL/logs
ERR_DIR=$MAXDAT_ETL_PATH/errors
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"


$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/prod_enhance_upd_new_attributes.kjb" -log="$LOG_DIR/Process_complaints_upd_prod_enhance_one_time.LOG" -level="$DETAIL_LOG_LEVEL"

