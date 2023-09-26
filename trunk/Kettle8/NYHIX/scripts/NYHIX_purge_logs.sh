#! /bin/ksh
# Script to remove files from the logs directory that are older than the number of days specificed in the .set_env file
#     or that have 0 length.
# =============================================================================
# Do not edit these four SVN_* variable values.  They are populated when 
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/NYHIX/ETL/scripts/NYHIX_purge_logs.sh $
# $Revision: 10175 $
# $Date: 2014-05-21 15:56:06 -0400 (Wed, 21 May 2014) $
# $Author: dd27179 $
# ============================================================================
# NOTE: This script has been modified from the TX copy to use absolute paths as a
#       stopgap for now and will be replace with the new version of this file when
#       the environment optimization (.set_env) occurs (DWD 5/20/14)

find /u01/maximus/maxdat/NYHIX8/logs/Appeals \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/ProcessComplaints \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/AgentTimeLine \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/DP_Scorecard \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/Egain \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/Engage \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/IDR \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/Initialization \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/MailFaxBatch \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/MFD_Run_Init_DAILY \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/MW_V2 \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/ProcessControlChart \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/ProcessDocNotifications \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/ProcessLetters \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/ProcessMailFaxDocV2 \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
find /u01/maximus/maxdat/NYHIX8/logs/ProductionPlanning \( -ctime +45 -o -size 0 \) -exec rm -f '{}' \;
