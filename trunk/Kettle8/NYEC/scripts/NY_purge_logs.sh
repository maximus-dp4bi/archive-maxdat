#! /bin/ksh
# Script to remove files from the logs directory that are older than the number of days specificed in the .set_env file
#     or that have 0 length.
# =============================================================================
# Do not edit these four SVN_* variable values.  They are populated when 
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/NYEC/ETL/scripts/NY_purge_logs.sh $
# $Revision: 10174 $
# $Date: 2014-05-21 13:54:31 -0600 (Wed, 21 May 2014) $
# $Author: dd27179 $
# ============================================================================
# NOTE: This script has been modified from the TX copy to use absolute paths as a
#       stopgap for now and will be replace with the new version of this file when
#       the environment optimization (.set_env) occurs (DWD 5/20/14)

find /u01/maximus/maxdat/NYEC8/logs \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
