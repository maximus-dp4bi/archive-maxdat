#!/bin/sh
. ~/.bash_profile

PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"

SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_DIR/ProcessApplication
LOG_DIR=$MAXDAT_LOG_DIR
LOG_LEVEL="Basic"

$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ProcessApp_RUNALL.kjb" -log="$LOG_DIR/MAXDAT_208_1.log" -level="$LOG_LEVEL" 

