#!/bin/bash
export MD_SETENV=/u01/maximus/maxdat-prd/NC_GENESYS/scripts/.set_env
source $MD_SETENV
#cron_NC_GENESYS_run_load.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# ================================================================================
# This is a cron job shell that will run the data load process
# ================================================================================
$MAXDAT_ETL_PATH/Do_GENESYS_Pull_H.sh > $MAXDAT_ETL_LOGS/${STCODE}_Do_GENESYS_Pull_H_cron_$(date +%Y%m%d_%H%M%S).log

