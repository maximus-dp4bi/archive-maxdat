#! /bin/bash
#source $MD_SETENV
# corp_purge_logs.sh
# =============================================================================
# Do not edit these four SVN_* variable values.  They are populated when 
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TNRD/scripts/tn_purge_logs.sh $
# $Revision: 16926 $
# $Date: 2016-04-06 09:47:18 -0700 (Wed, 06 Apr 2016) $
# $Author: aa24065 $
# ============================================================================
# Script to remove files from the logs directory that are older than the number 
#     of days specificed in the .set_env file or that have 0 length.
# Important: Make sure the cron knows $MD_SETENV
# ============================================================================

export MD_SETENV=/u01/maximus/maxdat-prd/TNRD/scripts/.set_env
source $MD_SETENV

find $MAXDAT_ETL_LOGS \( -ctime +$LOG_LIFE_DAYS -o -size 0 \) -exec rm -f '{}' \;
find /opt/maximus/maxdat-prd/TNRD/ReportArchive \( -ctime +30 -o -size 0 \) -exec rm -f '{}' \;
