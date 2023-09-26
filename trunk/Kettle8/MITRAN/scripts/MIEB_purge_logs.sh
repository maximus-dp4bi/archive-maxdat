#! /bin/bash
#source $.SET_ENV
# corp_purge_logs.sh
# =============================================================================
# Do not edit these four SVN_* variable values.  They are populated when 
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/MIEB/scripts/MIEB_purge_logs.sh $
# $Revision: 30435 $
# $Date: 2020-08-04 12:11:47 -0700 (Tue, 04 Aug 2020) $
# $Author: sr18956 $
# ============================================================================
# Script to remove files from the logs directory that are older than the number 
#     of days specificed in the .set_env file or that have 0 length.
# Important: Make sure the cron knows $MD_SETENV
# ============================================================================

location='/u01/maximus/maxdat/MITRAN/config'
source ${location}/.set_env

find $MAXDAT_ETL_LOGS \( -ctime +$LOG_LIFE_DAYS -o -size 0 \) -exec rm -f '{}' \;

#find files older than 7 days with less that 15kb size
find $MAXDAT_ETL_LOGS/Letters \( -type f -mmin +10080 -o -size -15 \) -exec rm -f '{}' \;
find $MAXDAT_ETL_LOGS \( -type f -mmin +10080 -o -size -15 \) -exec rm -f '{}' \;

#find files older than 30 days and delete
find $MAXDAT_ETL_LOGS/Letters \( -type f -mmin +43200 -o \) -exec rm -f '{}' \;
find $MAXDAT_ETL_LOGS \( -type f -mmin +43200 -o \) -exec rm -f '{}' \;

