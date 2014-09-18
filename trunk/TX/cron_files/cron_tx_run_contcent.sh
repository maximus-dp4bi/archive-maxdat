#! /bin/ksh
#Cron file to Contact Center
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
. ~/.profile

 $MAXDAT_ETL_PATH/ContactCenter/implementation/TXEB/bin/manage_scheduled_contact_center_jobs.sh  >> $MAXDAT_ETL_LOGS/tx_run_bpm.cron.log &

