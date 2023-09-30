#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# This is a cron job shell that will run the Run_PP_WFM_RUNALL7.sh process
# ================================================================================

export ENV_CODE="uat"
export STCODE=IL

echo "Starting export"
export IL_SETENV=/u01/maximus/maxdat-$ENV_CODE/$STCODE/ETL/scripts/.setenv_var7.sh

echo "Sourcing file"
source $IL_SETENV

echo "Starting cron_pp_wfm_runall.sh"
$MAXDAT_ETL_PATH/Run_PP_WFM_RUNALL7.sh > $MAXDAT_ETL_LOGS/Run_PP_WFM_RUNALL${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log