#! /bin/ksh
#Cron file to Contact Center
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/cron_files/cron_tx_run_get_dates_and_flatten_cc.sh $
# $Revision: 8508 $
# $Date: 2014-02-24 19:08:43 -0500 (Mon, 24 Feb 2014) $
# $Author: dd27179 $
. ~/.profile

$MAXDAT_ETL_PATH/ContactCenter/main/bin/run_tx_get_dates_and_flatten_contact_center.sh  >> $MAXDAT_ETL_LOGS/tx_run_get_dates_flatten_concent.cron.log &

