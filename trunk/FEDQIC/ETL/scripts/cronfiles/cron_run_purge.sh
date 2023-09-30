#!/bin/bash
export MD_SETENV=/u01/maximus/maxdat-prd/FEDQIC/scripts/.set_env
source $MD_SETENV
#cron_run_purge.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/FEDQIC/ETL/Scripts/cronfiles/cron_run_purge.sh $
# $Revision: 11183 $
# $Date: 2014-07-29 18:13:27 -0400 (Tue, 29 Jul 2014) $
# $Author: dd27179 $
# ================================================================================
# This is a cron job to purge old logs
# ================================================================================
$MAXDAT_ETL_PATH/fedqic_purge_logs.sh


