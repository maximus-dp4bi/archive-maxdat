#! /bin/ksh
#Cron file to adhoc Contact Center job
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/cron_files/cron_tx_run_adhoc_contcent.sh $
# $Revision: 8508 $
# $Date: 2014-07-01 10:51:00 -0500 (Tue, 01 Jul 2014) $
# $Author: sk51922 $
. ~/.profile

$MAXDAT_ETL_PATH/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh  >> $MAXDAT_ETL_LOGS/tx_manage_adhoc_contact_center_jobs.cron.log &

