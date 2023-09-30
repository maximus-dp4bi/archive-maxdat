#!/bin/ksh
#Cron file to run tx_run_bpm
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
. /tpxe4t/3rdparty/.profile

nohup ksh /ptxe4t/ETL_Scripts/scripts/tx_run_bpm_Let.sh > /ptxe4t/ETL_Logs/logs/tx_run_bpm_let.cron.log &

