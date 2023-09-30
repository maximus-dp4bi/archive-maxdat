#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TNRD/scripts/cronfiles/UAT_cron_tn_run_bpm.sh $
# $Revision: 15624 $
# $Date: 2015-10-22 15:39:17 -0700 (Thu, 22 Oct 2015) $
# $Author: gt83345 $
# This is a cron job shell that will run the bpm process
# ================================================================================
export MD_SETENV=/u01/maximus/maxdat-prd/TNRD8/scripts/.set_env
source $MD_SETENV

$MAXDAT_ETL_PATH/Run_TN_CoverKids.sh > $MAXDAT_ETL_LOGS/Run_TN_CoverKids_$(date +%Y%m%d_%H%M%S).log

#$MAXDAT_ETL_PATH/Run_TN_ReferralExtract.sh > $MAXDAT_ETL_LOGS/Run_TN_ReferralExtract_$(date +%Y%m%d_%H%M%S).log


