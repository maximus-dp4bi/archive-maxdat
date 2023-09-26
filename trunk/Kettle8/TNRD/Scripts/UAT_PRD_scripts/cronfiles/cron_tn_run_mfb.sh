#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/TNRD/scripts/cronfiles/cron_tn_run_mfb_PRD.sh $
# $Revision: 20698 $
# $Date: 2017-07-27 10:55:42 -0700 (Thu, 27 Jul 2017) $
# $Author: iv136523 $
# This is a cron job shell that will run the bpm process
# ================================================================================

export MD_SETENV=/u01/maximus/maxdat-uat/TNRD8/scripts/.set_env
source $MD_SETENV


$MAXDAT_ETL_PATH/tn_run_mfb.sh > $MAXDAT_ETL_LOGS/tn_run_mfb_$(date +%Y%m%d_%H%M%S).log