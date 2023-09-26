#!/bin/bash
source $MD_SETENV
#run_acts_connect.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/CADIR/ETL/Scripts/run_acts_connect.sh $
# $Revision: 1 $
# $Date: 2015-08-17 16:24:10 -0700 (Mon, 17 Aug 2015) $
# $Author: fm18957 $
# ================================================================================
# This is an AdHoc Test shell you can run to test database/mail server connections
# Run the Init Check to see if resources are available
# ================================================================================
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/Check_ACTS_Connect.kjb" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/${STCODE}_run_ACTS_connection_test_$(date +%Y%m%d_%H%M%S).log
