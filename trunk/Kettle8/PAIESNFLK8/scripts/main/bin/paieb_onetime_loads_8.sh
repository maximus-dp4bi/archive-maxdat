#!/bin/bash
PROGNAME=$(basename $0 .sh)

BASEDIR=$(dirname $0)
echo $BASEDIR

. $BASEDIR/.set_env

##source ./set_env.txt
#test.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/PAIEB/scripts/pa_run_connect_test.sh $
# $Revision: 31811 $
# $Date: 2021-04-14 12:51:03 -0400 (Wed, 14 Apr 2021) $
# $Author: sm152167 $
# ================================================================================
# This is an AdHoc Test shell you can run to test database/mail server connections
# Run the Init Check to see if resources are available
# ================================================================================
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/jobs/PAIEB_OneTime_Loads_8.kjb" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/PAIEB_OneTime_Loads_8_$(date +%Y%m%d_%H%M%S).log

