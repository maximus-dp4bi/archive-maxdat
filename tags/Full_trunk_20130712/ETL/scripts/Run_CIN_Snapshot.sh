#!/bin/sh
. ~/.bash_profile

#PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
PATH=$KETTLE_NY_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_NY_HOME

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_DIR
LOG_DIR=$MAXDAT_LOG_DIR
LOG_LEVEL="Basic"

                                                                                                   
$SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/LOAD_CIN_SNAPSHOT.ktr" -log="$LOG_DIR/LOAD_CIN_SNAPSHOT.log" -level="$LOG_LEVEL" 
