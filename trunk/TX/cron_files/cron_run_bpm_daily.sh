#!/bin/ksh
#Cron file to run tx_run_bpm
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/cron_files/cron_run_bpm_Let.sh $
# $Revision: 8508 $
# $Date: 2014-02-24 16:08:43 -0800 (Mon, 24 Feb 2014) $
# $Author: dd27179 $
. /tpxe4t/3rdparty/.profile

nohup ksh /ptxe4t/ETL_Scripts/scripts/tx_run_bpm_daily.sh > /ptxe4t/ETL_Logs/logs/tx_run_bpm_daily.cron.log &

