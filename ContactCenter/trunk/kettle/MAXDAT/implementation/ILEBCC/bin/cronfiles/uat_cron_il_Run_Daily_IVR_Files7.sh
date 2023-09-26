#!/bin/bash
#export ENV_CODE="dev"
export ENV_CODE="uat"
#export ENV_CODE="prd"
export STCODE=ILEBCC
export ILEBCC_SETENV="/u01/maximus/maxdat-$ENV_CODE/ILEBCC/scripts/ContactCenter/implementation/$STCODE/bin/.setenv_var7.sh"
source $ILEBCC_SETENV
#cron_il_Run_Daily_IVR_Files7.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# ================================================================================
# This is a cron job shell that will run the Daily IVR Files job
# ================================================================================
$MAXDAT_ETL_PATH/ContactCenter/main/bin/Run_Daily_IVR_Files7.sh > $MAXDAT_ETL_LOGS/Run_Daily_IVR_Files7_$(date +%Y%m%d_%H%M%S).log
