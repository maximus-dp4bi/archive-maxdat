#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# This is a cron job shell that will run the load_New_Queue_Flag_for_Alert.sh process
# ================================================================================
export ENV_CODE="dev"
export STCODE="ILEBCC"

echo "Starting export"
export ILEBCC_SETENV="/u01/maximus/maxdat-$ENV_CODE/$STCODE/scripts/ContactCenter/implementation/$STCODE/bin/.setenv_var7.sh"

echo "Sourcing file"
source $ILEBCC_SETENV

echo "Starting load_New_Queue_Flag_for_Alert.sh"
$MAXDAT_ETL_PATH/ContactCenter/main/bin/load_New_Queue_Flag_for_Alert.sh > $MAXDAT_ETL_LOGS/ContactCenter/load_New_Queue_Flag_for_Alert.sh${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log
