#!/bin/bash
. /u01/maximus/maxdat-prd/CO/ETL/scripts/set_maxdat_env_variables.sh

# Run to test for connection only
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/run_conn_test.kjb" -level="$DETAIL_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/run_conn_test.log
