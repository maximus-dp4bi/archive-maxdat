#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/TNRD/scripts/cronfiles/cron_tn_run_mfb_DEV.sh $
# $Revision: 20648 $
# $Date: 2017-07-24 14:17:59 -0700 (Mon, 24 Jul 2017) $
# $Author: iv136523 $
# This is a cron job shell that will run the bpm process
# ================================================================================

echo "Starting export"
export MD_SETENV=/u01/maximus/maxdat-dev/TNRD/scripts/.set_env

echo "Sourcing file"
source $MD_SETENV

echo "Starting tn_run_mfb.sh"
$MAXDAT_ETL_PATH/tn_run_mfb.sh > $MAXDAT_ETL_LOGS/tn_run_mfb_$(date +%Y%m%d_%H%M%S).log
