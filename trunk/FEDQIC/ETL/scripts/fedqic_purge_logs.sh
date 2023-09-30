#! /bin/bash
source $MD_SETENV
# corp_purge_logs.sh
# =============================================================================
# Do not edit these four SVN_* variable values.  They are populated when 
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/FEDQIC/ETL/Scripts/fedqic_purge_logs.sh $
# $Revision: 10933 $
# $Date: 2014-07-15 19:24:10 -0400 (Tue, 15 Jul 2014) $
# $Author: dd27179 $
# ============================================================================
# Script to remove files from the logs directory that are older than the number 
#     of days specificed in the .set_env file or that have 0 length.
# Important: Make sure the cron knows $MD_SETENV
# ============================================================================
find $MAXDAT_ETL_LOGS \( -ctime +$LOG_LIFE_DAYS -o -size 0 \) -exec rm -f '{}' \;
