#!/bin/bash
export MD_SETENV=/u01/maximus/maxdat-uat/CADIR/scripts/.set_env
source $MD_SETENV
#cron_purge_files.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# ================================================================================
# This is a cron job to purge old logs
# ================================================================================
$MAXDAT_ETL_PATH/cadir_pruge_logs.sh


