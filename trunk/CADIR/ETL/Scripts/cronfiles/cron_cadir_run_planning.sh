#!/bin/bash
export MD_SETENV=/u01/maximus/maxdat-prd/CADIR/scripts/.set_env
source $MD_SETENV
#cron_cadir_run_bpm.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/CADIR/ETL/Scripts/cronfiles/cron_cadir_run_planning.sh $
# $Revision: 11183 $
# $Date: 2014-07-29 17:13:27 -0500 (Tue, 29 Jul 2014) $
# $Author: dd27179 $
# ================================================================================
# This is a cron job shell that will run the bpm process
# ================================================================================
$MAXDAT_ETL_PATH/cadir_run_planning.sh > $MAXDAT_ETL_LOGS/${STCODE}_bpm_cron_$(date +%Y%m%d_%H%M%S).log

