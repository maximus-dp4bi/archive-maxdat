#!/bin/ksh
. ~/.profile
#Run_onetime_ClientInquiry_Region_Update.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/TX/ETL/scripts/Run_microstrategy_event_check.sh $
# $Revision: 21687 $
# $Date: 2017-11-08 14:40:11 -0800 (Wed, 08 Nov 2017) $
# $Author: aa24065 $

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

INIT_OK="$CUSTOM_DIR/mstr_event_check.txt"
CHILD_FAIL="/tmp/mstr_event_check.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/Run_microstrategy_event_check.txt"
EMAIL_SUBJECT="Errors With Run_microstrategy_event_check.sh"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#init check
ksh $SCRIPTS_DIR/pan.sh -file="$CUSTOM_DIR/MSTR_CheckJob_Event.ktr" -level="$LOG_LEVEL"  >> $LOG_DIR/MSTR_CheckJob_Event_$(date +%Y%m%d_%H%M%S).log

rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - MSTR_CheckJob_Event.ktr, aborting run" >> $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
    exit $rc
fi
