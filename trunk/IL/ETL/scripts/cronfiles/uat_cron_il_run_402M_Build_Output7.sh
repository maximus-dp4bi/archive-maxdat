#!/bin/bash
#export ENV_CODE="dev"
export ENV_CODE="uat"
#export ENV_CODE="prd"
export STCODE=IL
export IL_SETENV=/u01/maximus/maxdat-$ENV_CODE/$STCODE/ETL/scripts/.setenv_var7.sh
source $IL_SETENV
#cron_il_run_402M_Build_Output7.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# ================================================================================
# This is a cron job shell that will run the Agency Reports 402M  Built Output process
# ================================================================================
$MAXDAT_ETL_PATH/${STCODE}_run_402M_Build_Output7.sh > $MAXDAT_ETL_LOGS/${STCODE}_run_402M_Build_Output7_$(date +%Y%m%d_%H%M%S).log
