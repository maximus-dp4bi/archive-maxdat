#!/bin/bash
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
export ENV_CODE="dev"
#export ENV_CODE="uat"
#export ENV_CODE="prd"
export STCODE=ETL
export NY_SETENV=/u01/maximus/maxdat-$ENV_CODE/$STCODE/scripts/.setenv_var7.sh
source $NY_SETENV
#cron_il_run_bpm7.sh

$MAXDAT_ETL_PATH/run_bpm7.sh > $MAXDAT_ETL_LOGS/run_bpm7_$(date +%Y%m%d_%H%M%S).log
