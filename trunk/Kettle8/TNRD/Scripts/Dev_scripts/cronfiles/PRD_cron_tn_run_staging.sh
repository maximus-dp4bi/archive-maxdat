#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TNRD/scripts/cronfiles/UAT_cron_tn_run_bpm.sh $
# $Revision: 15624 $
# $Date: 2015-10-22 16:39:17 -0600 (Thu, 22 Oct 2015) $
# $Author: gt83345 $
# This is a cron job shell that runs  
# ================================================================================
export TN_SETENV=/u01/maximus/maxdat-prd/TNRD/scripts/.set_env
source $TN_SETENV

$MAXDAT_ETL_PATH/Run_TN_Staging.sh > $MAXDAT_ETL_LOGS/Run_TN_Staging_$(date +%Y%m%d_%H%M%S).log

export day_of_week=`date '+%u'`

if [ $day_of_week -eq 0 ]; then
then 
   $MAXDAT_ETL_PATH/Run_app_header_audit_report.sh > $MAXDAT_ETL_LOGS/Run_app_header_audit_report_$(date +%Y%m%d_%H%M%S).log
fi