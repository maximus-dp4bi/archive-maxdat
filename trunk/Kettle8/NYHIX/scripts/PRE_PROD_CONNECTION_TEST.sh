#!/bin/ksh
#nyhix_run_bpm.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/NYHIX/ETL/scripts/nyhix_run_bpm.sh $
# $Revision: 10233 $
# $Date: 2014-05-27 13:45:11 -0500 (Tue, 27 May 2014) $
# $Author: bt25944 $

location='/u01/maximus/maxdat/NYHIX8/config'
source ${location}/.set_env

PROGNAME=$(basename $0 .sh)
function error_exit
{
#       ----------------------------------------------------------------
#       Function for exit due to fatal program error
#               Accepts 1 argument:
#                       string containing descriptive error message
#       ----------------------------------------------------------------
        echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
        rm -f $INIT_OK
        exit 1
}
export KETTLE_HOME=$KETTLE_NYHIX_HOME

KTR_LOG_LEVEL="Detailed"
KJB_LOG_LEVEL="Detailed"
KJB_LOG_ROWLEVEL="Rowlevel"
INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_PRE_PROD_CONNECTION_TEST.txt"
#CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"
#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="PRE-PROD Connection TEST"
EMAIL_SUBJECT="PRE-PROD Connection TEST"

#init check
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/${MODULE_INIT}/PRE_PROD_CONNECTION_TEST.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/${MODULE_INIT}/PRE_PROD_CONNECTION_TEST_$(date +%Y%m%d_%H%M%S).log
if [[ $rc == 0 || $rc = '' ]] ; then
        rm -f $INIT_OK
        echo "Successfully ran: $rc - PRE_PROD_CONNECTION_TEST.kjb"
        exit $rc
else
        echo "exited with status: $rc - PRE_PROD_CONNECTION_TEST.kjb, aborting run in $STCODE" >> $EMAIL_MESSAGE
        rm -f $INIT_OK
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        exit $rc
fi

