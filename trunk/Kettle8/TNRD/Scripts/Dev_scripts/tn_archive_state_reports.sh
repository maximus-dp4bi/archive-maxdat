#! /bin/bash
#source $MD_SETENV
# archive_state_reports.sh
# =============================================================================
# Do not edit these four SVN_* variable values.  They are populated when 
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/TNRD/scripts/tn_archive_state_reports.sh $
# $Revision: 16936 $
# $Date: 2016-04-07 09:57:28 -0700 (Thu, 07 Apr 2016) $
# $Author: aa24065 $
# ============================================================================
# Script to archive reports that are older than the number 
#     of days specificed in the .set_env file or that have 0 length.
# Important: Make sure the cron knows $MD_SETENV
# ============================================================================

export MD_SETENV=/u01/maximus/maxdat-uat/TNRD/scripts/.set_env
source $MD_SETENV

find /u01/maximus/maxdat-$ENV_CODE/TNRD/moveit/*.zip \( -ctime +30 -o -size 0 \) -exec mv {} /u01/maximus/maxdat-$ENV_CODE/TNRD/ReportArchive \;

