#!/bin/bash
export MD_SETENV=/u01/maximus/maxdat-prd/CADIR8/scripts/.set_env
source $MD_SETENV
#cron_cadir_run_bpm.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# ================================================================================
# This is a cron job shell that will run the bpm process
# ================================================================================
$MAXDAT_ETL_PATH/cadir_run_bpm.sh > $MAXDAT_ETL_LOGS/${STCODE}_bpm_cron_$(date +%Y%m%d_%H%M%S).log

