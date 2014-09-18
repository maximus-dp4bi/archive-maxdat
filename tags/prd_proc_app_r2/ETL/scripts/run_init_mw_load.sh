#!/bin/sh
. ~/.bash_profile

PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR="/u01/maximus/maxdat-prd/ETL/scripts"
LOG_DIR="/u01/maximus/maxdat-prd/ETL/logs"
LOG_LEVEL="Basic"

$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/Load_OLTP_Lookups.kjb" -log="$LOG_DIR/Load_OLTP_Lookups.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/MW_Initial_load1.ktr" -log="$LOG_DIR/MW_Initial_load1.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Insert.ktr" -log="$LOG_DIR/ManageWork_Insert.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Update1.ktr" -log="$LOG_DIR/ManageWork_Update1.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Update2.ktr" -log="$LOG_DIR/ManageWork_Update2.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Transform.ktr" -log="$LOG_DIR/ManageWork_Transform.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Save_Variables.ktr" -log="$LOG_DIR/ManageWork_Save_Variables.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/MW_Initial_load2.ktr" -log="$LOG_DIR/MW_Initial_load2.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Insert.ktr" -log="$LOG_DIR/ManageWork_Insert_2nd.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Update1.ktr" -log="$LOG_DIR/ManageWork_Update1_2nd.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Update2.ktr" -log="$LOG_DIR/ManageWork_Update2_2nd.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Transform.ktr" -log="$LOG_DIR/ManageWork_Transform_2nd.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Save_Variables.ktr" -log="$LOG_DIR/ManageWork_Save_Variables.log" -level="$LOG_LEVEL"

