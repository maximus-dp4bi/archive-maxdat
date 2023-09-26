#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/TNRD/scripts/cronfiles/DEV_cron_tn_run_bpm.sh $
# $Revision: 15624 $
# $Date: 2015-10-22 15:39:17 -0700 (Thu, 22 Oct 2015) $
# $Author: gt83345 $
# This is a cron job shell that will run the bpm process
# ================================================================================
export MD_SETENV=/u01/maximus/maxdat-dev/TNRD/scripts/.set_env
source $MD_SETENV

$MAXDAT_ETL_PATH/tn_run_bpm.sh > $MAXDAT_ETL_LOGS/tn_run_bpm_$(date +%Y%m%d_%H%M%S).log