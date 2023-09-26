#! /bin/ksh
# Script to remove files from the logs directory that are older than the number of days specificed in the .set_env file
#     or that have 0 length.
# =============================================================================
# Do not edit these four SVN_* variable values.  They are populated when 
#    you commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# ============================================================================
# NOTE: This script has been modified from the TX copy to use absolute paths as a
#       stopgap for now and will be replace with the new version of this file when
#       the environment optimization (.set_env) occurs (DWD 5/20/14)

find /u01/maximus/maxdat-*/NYHIX/ETL/logs \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;

