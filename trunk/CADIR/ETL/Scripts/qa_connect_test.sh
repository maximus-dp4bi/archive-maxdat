#!/bin/bash
source $MD_SETENV
#qa_connect_test.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/CADIR/ETL/Scripts/cadir_connect_test.sh $
# $Revision: 10933 $
# $Date: 2014-07-15 16:24:10 -0700 (Tue, 15 Jul 2014) $
# $Author: dd27179 $
# ================================================================================
# This is an AdHoc Test shell you can run to test database/mail server connections
# Run the Init Check to see if resources are available
# ================================================================================
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/test_qa_db.kjb" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/${STCODE}_run_qa_connection_test_$(date +%Y%m%d_%H%M%S).log

