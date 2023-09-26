#!/bin/bash
#export MD_SETENV=/u01/maximus/maxdat-prd/CADIR8/scripts/.set_env
#. $MD_SETENV
source $MD_SETENV
#run_sqid_connect.sh
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
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/Check_SQID_CONNECT.kjb" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/${STCODE}_run_sqid_connect_$(date +%Y%m%d_%H%M%S).log

