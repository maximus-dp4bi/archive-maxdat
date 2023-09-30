#! /bin/ksh
#Cron file to Contact Center
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/cron_files/cron_tx_run_contcent.sh $
# $Revision: 8508 $
# $Date: 2014-02-24 19:08:43 -0500 (Mon, 24 Feb 2014) $
# $Author: dd27179 $
. /tpxe4t/3rdparty/.profile

 /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_scheduled_contact_center_jobs.sh  >> $MAXDAT_ETL_LOGS/tx_run_bpm.cron.log &

