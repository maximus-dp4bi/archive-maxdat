#!/bin/ksh
. ~/.profile
#Run_onetime_ClientSupplInfo_Stg.sh
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

PATH=$MAXDAT_KETTLE_DIR/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PENTAHO_JAVA_HOME="/u25/app/product/java/j6sdk"
SCRIPTS_DIR=$MAXDAT_KETTLE_DIR
export PATH

CUSTOM_DIR=$MAXDAT_ETL_PATH
LOG_DIR=$MAXDAT_ETL_LOGS
LOG_LEVEL="Detailed"

INIT_OK="$CUSTOM_DIR/run_init_check.txt"
CHILD_FAIL="/tmp/child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/Run_onetime_ClientSupplInfo_Stg.txt"
EMAIL_SUBJECT="Errors With Run_onetime_ClientSupplInfo_Stg.sh"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#init check
ksh $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/Load_Client_Supplementary_Info_Stg_Onetime.ktr" -level="$LOG_LEVEL"  >> $LOG_DIR/Load_Client_Supplementary_Info_Stg_Onetime_$(date +%Y%m%d_%H%M%S).log
#creates run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - Load_Client_Supplementary_Info_Stg_Onetime.ktr, aborting run" >> $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
    exit $rc
fi
