#!/bin/ksh
. ~/.profile
#tx_run_bpm.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/tx_run_bpm.sh $
# $Revision: 6000 $
# $Date: 2013-10-09 10:27:30 -0500 (Wed, 09 Oct 2013) $
# $Author: dd27179 $
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
	rm -f $INIT_OK
	exit 1
}

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm_MEA_P4.sh in $ENV_CODE"

ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/${STCODE}_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - ${STCODE}_BPM_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
	rm -f $INIT_OK
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
else
   $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/Cost_Share_Details_STG.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Cost_Share_Details_STG_$(date +%Y%m%d_%H%M%S).log &	
fi
