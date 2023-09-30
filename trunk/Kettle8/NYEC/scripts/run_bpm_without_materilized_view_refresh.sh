#!/bin/sh

# use settings in home
source /u01/maximus/maxdat/NYEC8/config/.set_env

DATE=`/bin/date +'%Y%m%d%H%M'`

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_DIR/$MODULE_INIT/Run_Initiatization.kjb" -log="$MAXDAT_LOG_DIR/$MODULE_INIT/Run_Initiatization_$DATE.log" -level="$LOG_LEVEL" && $MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_DIR/$MODULE_MW/ManageWork_Insert.ktr" -log="$MAXDAT_LOG_DIR/$MODULE_MW/ManageWork_Insert_$DATE.log" -level="$LOG_LEVEL" && $MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_DIR/$MODULE_MW/ManageWork_Update1.ktr" -log="$MAXDAT_LOG_DIR/$MODULE_MW/ManageWork_Update1_$DATE.log" -level="$LOG_LEVEL" && $MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_DIR/$MODULE_MW/ManageWork_Update2.ktr" -log="$MAXDAT_LOG_DIR/$MODULE_MW/ManageWork_Update2_$DATE.log" -level="$LOG_LEVEL" && $MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_DIR/$MODULE_MW/ManageWork_Transform.ktr" -log="$MAXDAT_LOG_DIR/$MODULE_MW/ManageWork_Transform_$DATE.log" -level="$LOG_LEVEL" && $MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_DIR/$MODULE_MW/ManageWork_Save_Variables.ktr" -log="$MAXDAT_LOG_DIR/$MODULE_MW/ManageWork_Save_Variables_$DATE.log" -level="$LOG_LEVEL"

