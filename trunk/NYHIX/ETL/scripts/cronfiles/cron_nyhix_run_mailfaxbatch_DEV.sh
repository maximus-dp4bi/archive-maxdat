#!/bin/bash
export ENV_CODE="dev"
export STCODE=NYHIX
export NYHIX_SETENV=/u01/maximus/maxdat-$ENV_CODE/$STCODE/ETL/scripts/.setenv_var7.sh
source $NYHIX_SETENV
# nyhix_run_mailfaxbatch.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: $
# $Revision: $
# $Date:  $
# $Author: $
# ================================================================================
# This is a cron job shell that will run the nyhix_run_bpm.sh process
# ================================================================================
$MAXDAT_ETL_PATH/nyhix_run_mailfaxbatch7.sh > $MAXDAT_ETL_LOGS/nyhix_run_mailfaxbatch7_$(date +%Y%m%d_%H%M%S).log
