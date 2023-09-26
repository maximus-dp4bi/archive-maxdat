#!/bin/bash
source /u01/maximus/maxdat/IL8/config/.set_env
#corp_run_connect_test.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# ================================================================================
# This is an AdHoc Test shell you can run to test database/mail server connections
# Run the Init Check to see if resources are available
# ================================================================================
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_INIT/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/$MODULE_INIT/${STCODE}_run_conn_test_$(date +%Y%m%d_%H%M%S).log

