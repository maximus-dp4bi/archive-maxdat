#!/bin/ksh
. /dtxe4t/ETL_Scripts/scripts8/.set_env
#Run_onetime_CLIENT_INQUIRY_20131118.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.

PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------

	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

SCRIPTS_DIR=$MAXDAT_KETTLE_DIR


CUSTOM_DIR=$MAXDAT_ETL_PATH
LOG_DIR=$MAXDAT_ETL_LOGS
LOG_LEVEL="Detailed"

INIT_OK="$CUSTOM_DIR/run_init_check.txt"
CHILD_FAIL="/tmp/child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/Run_onetime_ClientInquiry_Manual_Events.txt"
EMAIL_SUBJECT="Errors With Run_onetime_ClientInquiry_Manual_Events.sh"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#init check
ksh $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/Run_onetime_ClientInquiry_Manual_Events.ktr" -level="$LOG_LEVEL"  >> $LOG_DIR/Run_onetime_ClientInquiry_Manual_Events_$(date +%Y%m%d_%H%M%S).log
#creates run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - Run_onetime_ClientInquiry_Manual_Events.ktr, aborting run" >> $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
    exit $rc
fi
