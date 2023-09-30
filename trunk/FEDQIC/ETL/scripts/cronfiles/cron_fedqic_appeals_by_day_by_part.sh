#!/bin/bash
export MD_SETENV=/u01/maximus/maxdat-prd/FEDQIC/scripts/.set_env
source $MD_SETENV
#cron_fedqic_run_bpm.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/FEDQIC/ETL/scripts/cronfiles/cron_fedqic_run_bpm.sh $
# $Revision: 14761 $
# $Date: 2015-07-13 18:37:34 -0400 (Mon, 13 Jul 2015) $
# $Author: pa28085 $
# ================================================================================
# This is a cron job shell that will run the bpm process
# ================================================================================
$MAXDAT_ETL_PATH/AppealModule/fedqic_update_appeals_by_day_by_part.sh > $MAXDAT_ETL_LOGS/${STCODE}_update_appeals_by_day_by_part_cron_$(date +%Y%m%d_%H%M%S).log

