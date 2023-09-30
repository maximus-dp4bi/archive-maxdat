#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TNRD/scripts/cronfiles/PRD_cron_tn_run_bpm.sh $
# $Revision: 15875 $
# $Date: 2015-11-23 13:30:47 -0800 (Mon, 23 Nov 2015) $
# $Author: aa24065 $
# This is a cron job shell that will run the bpm process
# ================================================================================
export MD_SETENV=/u01/maximus/maxdat-prd/TNRD/scripts/.set_env
source $MD_SETENV

$MAXDAT_ETL_PATH/tn_run_bihourly.sh > $MAXDAT_ETL_LOGS/tn_run_bihourly_$(date +%Y%m%d_%H%M%S).log