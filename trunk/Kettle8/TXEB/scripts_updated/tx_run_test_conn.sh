#!/bin/ksh
. /dtxe4t/ETL_Scripts/scripts8/.set_env
#tx_run_test_conn.sh

INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_check.txt"
CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"

#init check
ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/${STCODE}_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
