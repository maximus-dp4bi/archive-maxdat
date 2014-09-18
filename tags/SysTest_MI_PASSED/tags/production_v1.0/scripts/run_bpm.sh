#!/bin/sh

# use settings in home
#. ~/.bash_profile

PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR="/u01/maximus/maxdat-prd/ETL/scripts"
LOG_DIR="/u01/maximus/maxdat-prd/ETL/logs"
LOG_LEVEL="Basic"
DATE=`/bin/date +'%Y%m%d%H%M'`

$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/Run_Initiatization.kjb" -log="$LOG_DIR/Run_Initiatization_$DATE.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Insert.ktr" -log="$LOG_DIR/ManageWork_Insert_$DATE.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Update1.ktr" -log="$LOG_DIR/ManageWork_Update1_$DATE.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Update2.ktr" -log="$LOG_DIR/ManageWork_Update2_$DATE.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Transform.ktr" -log="$LOG_DIR/ManageWork_Transform_$DATE.log" -level="$LOG_LEVEL" && $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_Save_Variables.ktr" -log="$LOG_DIR/ManageWork_Save_Variables_$DATE.log" -level="$LOG_LEVEL"&& $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ManageWork_BPM_EVENT_MV_REFRESH.ktr" -log="$LOG_DIR/ManageWork_BPM_EVENT_MV_REFRESH_$DATE.log" -level="$LOG_LEVEL"

