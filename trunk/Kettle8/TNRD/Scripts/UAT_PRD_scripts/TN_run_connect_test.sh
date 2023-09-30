#!/bin/bash
source ./.set_env
#corp_run_connect_test.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/corp_run_connect_test.sh $
# $Revision: 10349 $
# $Date: 2014-06-02 16:29:15 -0700 (Mon, 02 Jun 2014) $
# $Author: dd27179 $
# ================================================================================
# This is an AdHoc Test shell you can run to test database/mail server connections
# Run the Init Check to see if resources are available
# ================================================================================
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/${STCODE}_run_conn_test_$(date +%Y%m%d_%H%M%S).log

