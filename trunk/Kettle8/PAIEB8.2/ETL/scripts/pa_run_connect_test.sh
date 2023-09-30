#!/bin/bash
source ./.set_env8.sh
#corp_run_connect_test.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/PAIEB/ETL/scripts/pa_run_connect_test.sh $
# $Revision: 25785 $
# $Date: 2018-12-18 14:41:55 -0600 (Tue, 18 Dec 2018) $
# $Author: aa24065 $
# ================================================================================
# This is an AdHoc Test shell you can run to test database/mail server connections
# Run the Init Check to see if resources are available
# ================================================================================
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/${STCODE}_run_conn_test_$(date +%Y%m%d_%H%M%S).log

