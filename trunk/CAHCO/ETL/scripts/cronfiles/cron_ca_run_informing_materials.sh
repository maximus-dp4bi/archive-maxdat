#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# This is a cron job shell that will run the bpm process
# ================================================================================
export HCO_ETL_PATH="/u01/maximus/maxdat/CAHCO/scripts"
export HCO_ETL_LOGS="/u01/maximus/maxdat/CAHCO/logs/InformingMaterials"

$HCO_ETL_PATH/CAHCO_run_informing_materials.sh > $HCO_ETL_LOGS/CAHCO_run_IM_$(date +%Y%m%d_%H%M%S).log


