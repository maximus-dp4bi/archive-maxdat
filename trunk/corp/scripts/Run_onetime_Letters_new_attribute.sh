#!/bin/ksh
. ~/.bash_profile

PATH=$KETTLE_NYHIX_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_NYHIX_HOME
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_45"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_PATH
LOG_DIR=/u01/maximus/maxdat-uat/NYHIX/ETL/logs
ERR_DIR=$MAXDAT_ETL_PATH/errors
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"


$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ProcessLetters_upd_family_member_number_onetime.kjb" -log="$LOG_DIR/Process_letters_upd_new_fields_one_time.LOG" -level="$DETAIL_LOG_LEVEL"
