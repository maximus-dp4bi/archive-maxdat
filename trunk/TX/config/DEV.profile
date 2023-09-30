# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/tx_run_bpm.sh $
# $Revision: 5153 $
# $Date: 2013-09-06 14:35:28 -0500 (Fri, 06 Sep 2013) $
# $Author: dd27179 $
MAIL=/usr/mail/${LOGNAME:?}

# Setting Location Vars
export MAXDAT_KETTLE_DIR=/u25/app/product/kettle/4.2/data-integration
export MAXDAT_ETL_PATH=/u25/ETL_Scripts/DEV/scripts
export MAXDAT_ETL_LOGS=/u25/ETL_Logs/DEV
export STCODE=TX
