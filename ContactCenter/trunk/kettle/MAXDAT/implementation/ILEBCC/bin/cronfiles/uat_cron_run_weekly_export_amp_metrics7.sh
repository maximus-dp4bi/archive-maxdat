#!/bin/bash
#export ENV_CODE="dev"
export ENV_CODE="uat"
#export ENV_CODE="prd"
export STCODE=ILEBCC
export IL_SETENV="/u01/maximus/maxdat-$ENV_CODE/$STCODE/scripts/ContactCenter/implementation/ILEBCC/bin/.setenv_var7.sh"
source $IL_SETENV
#cron_run_weekly_export_amp_metrics7.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# ================================================================================
# This is a cron job shell that will run the Agency Reports 402 process
# ================================================================================

$MAXDAT_ETL_PATH/ContactCenter/main/bin/run_scheduled_export_amp_metrics7.sh "WEEKLY" > $MAXDAT_ETL_LOGS/cron_run_weekly_export_amp_metrics${PDI_VERSION}_$(date +%Y-%m-%d_%H-%M-%S).log
