#! /bin/ksh
# Script to remove files from the logs directory that are older than the number of days specificed in the .set_env file
#     or that have 0 length.
# =============================================================================
# Do not edit these four SVN_* variable values.  They are populated when 
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/IL/scripts/IL_purge_logs.sh $
# $Revision: 28523 $
# $Date: 2019-12-12 15:33:59 -0800 (Thu, 12 Dec 2019) $
# $Author: gt83345 $
# ============================================================================
# NOTE: This script has been modified from the TX copy to use absolute paths as a
#       stopgap for now and will be replace with the new version of this file when
#       the environment optimization (.set_env) occurs (DWD 5/20/14)

find /u01/maximus/maxdat/Adherence/logs \( -ctime +45 -o -size 0 \) -and \(  -name '*.zip' -or -name '*.log' \) -exec rm -f '{}' \;
