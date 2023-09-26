#! /bin/ksh
# Script to remove files from the logs directory that are older than the number of days specificed in the .set_env file
#     or that have 0 length.
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/TX/ETL/scripts/purge_logs.sh $
# $Revision: 6904 $
# $Date: 2013-11-15 09:13:49 -0800 (Fri, 15 Nov 2013) $
# $Author: dd27179 $
. ./.set_env

find $MAXDAT_ETL_LOGS \( -ctime +$LOG_LIFE_DAYS -o -size 0 \) -exec rm -f '{}' \;

# test command
#find $MAXDAT_ETL_LOGS \( -ctime +$LOG_LIFE_DAYS -o -size 0 \) -exec ls -l '{}' \; 
