#!/bin/sh
. ~/.bash_profile

. set_maxdat_env_variables.sh

SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
#CUSTOM_DIR=$MAXDAT_ETL_DIR/scripts
CUSTOM_DIR=$MAXDAT_ETL_DIR/
LOG_DIR=$MAXDAT_LOG_DIR


LOG_LEVEL="Basic"

$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/TestDBConnection.kjb" -log="$LOG_DIR/TestDBConnection.log" -level="$LOG_LEVEL"

