#! /bin/ksh
#Cron file to run tx_run_emrs
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
. /tpxe4t/3rdparty/.profile

nohup $MAXDAT_ETL_PATH/tx_run_emrs.sh > $MAXDAT_ETL_LOGS/tx_run_emrs.cron.log &

