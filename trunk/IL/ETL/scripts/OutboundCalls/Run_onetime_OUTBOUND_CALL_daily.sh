#!/bin/bash
. ~/.bash_profile
#run_bpm.sh
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

#Complete the environment - Specific to IL only
#---------------------------
#redefining these paths here to keep them separate frm NY
export STCODE=IL
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/ETL/logs
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/$STCODE/ETL/scripts
PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME
#--------------------------

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_check.txt"
OC_FAIL="/tmp/${STCODE}_OutboundCalls_Onetime_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm.sh in $ENV_CODE"
rm -f $EMAIL_MESSAGE $OC_FAIL

$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/OutboundCalls/OutboundCalls_Runall.kjb 'Detailed' >> $MAXDAT_ETL_LOGS/OutboundCalls_Runall_$(date +%Y%m%d_%H%M%S).log

rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - ONETIME_OutboundCalls_Runall, aborting run" >> $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
    exit $rc
fi

