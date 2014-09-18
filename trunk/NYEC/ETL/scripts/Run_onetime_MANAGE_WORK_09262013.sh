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

#set up the environment
#PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
PATH=$KETTLE_NY_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_NY_HOME


export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_DIR
LOG_DIR=$MAXDAT_LOG_DIR
LOG_LEVEL="Detailed"

INIT_OK="$CUSTOM_DIR/run_init_check.txt"
CHILD_FAIL="/tmp/child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With run_bpm.sh"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#init check
#assumption that bpm_init_check.kjb and Run_Initiatization.kjb are present in $CUSTOM_DIR
#$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/bpm_Init_check.kjb >> $LOG_DIR/bpm_init_check_$(date +%Y%m%d_%H%M%S).log
$SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/ONETIME_mw_capture_incident_tracking_number.ktr" -level="$LOG_LEVEL"  >> $LOG_DIR/ONETIME_mw_capture_incident_tracking_number_$(date +%Y%m%d_%H%M%S).log
#creates run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - ONETIME_mw_capture_incident_tracking_number.ktr, aborting run" >> $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
    exit $rc
fi