#! /bin/ksh
#Cron file to run tx_run_bpm
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
. /tpxe4t/3rdparty/.profile

nohup ksh $MAXDAT_ETL_PATH/tx_run_bpm.sh >> $MAXDAT_ETL_LOGS/tx_run_bpm.cron.log &

