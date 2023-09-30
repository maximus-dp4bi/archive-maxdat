#!/bin/bash
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# This is a cron job shell that will run the manage_adhoc_contact_center_jobs7.sh process
# ================================================================================
export ENV_CODE="uat"
export STCODE="ILEBCC"

echo "Starting export"
export ILEBCC_SETENV="/u01/maximus/maxdat-$ENV_CODE/$STCODE/scripts/ContactCenter/implementation/$STCODE/bin/.setenv_var7.sh"

echo "Sourcing file"
source $ILEBCC_SETENV

echo "Starting manage_adhoc_contact_center_jobs7.sh"
$MAXDAT_ETL_PATH/ContactCenter/main/bin/manage_adhoc_contact_center_jobs7.sh > $MAXDAT_ETL_LOGS/ContactCenter/manage_adhoc_contact_center_jobs${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log
