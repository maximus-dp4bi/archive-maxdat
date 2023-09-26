#!/bin/sh
. /u01/maximus/maxdat/IL8/config/.set_env



$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_SCI/ClientInquiry_Event_Inserts_March_One_Time.kjb" -log="$MAXDAT_ETL_LOGS/$MODULE_SCI/ClientInquiry_Event_Inserts_March_One_Time.LOG" -level="$DETAIL_LOG_LEVEL"

