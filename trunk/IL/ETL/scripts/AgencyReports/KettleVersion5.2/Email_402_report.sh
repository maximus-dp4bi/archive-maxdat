#!/bin/bash

PROGNAME=$(basename $0 .sh)
function error_exit
{

#       ----------------------------------------------------------------
#       Function for exit due to fatal program error
#               Accepts 1 argument:
#                       string containing descriptive error message
#       ----------------------------------------------------------------


        /bin/echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
        rm -f $INIT_OK
        exit 1
}

#Complete the environment - Specific to IL only

#---------------------------
#redefining these paths here to keep them separate frm NY
export STCODE=IL
ENV='prd'
export MAXDAT_ETL_LOGS=/u01/maximus/maxdat-${ENV}/${STCODE}/ETL/logs
export MAXDAT_ETL_PATH=/u01/maximus/maxdat-${ENV}/${STCODE}/ETL/scripts/AgencyReports
LOG_FILE=$"`ls -rt ${MAXDAT_ETL_LOGS}/Run_5_2_ILEB_402_* | tail -1`"
RPT_FILE=`ls -rt ${MAXDAT_ETL_PATH}/working | tail -1`

#--------------------------
/bin/echo "Executing Email_402_report.sh" >> $LOG_FILE
INIT_OK="$MAXDAT_ETL_PATH/run_check.txt"

#mail related variables
EMAIL="guydthibodeau@maximus.com,MAXDatILEBReports@maxcs.maxinc.com"
EMAIL_MESSAGE="/tmp/${STCODE}_Email_402_report_ERROR.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_Email_402_report.sh in $ENV_CODE"
/bin/echo "Email_402_report - Email Variables Set: ${EMAIL}" >> $LOG_FILE

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $INIT_OK ]] ; then
   /bin/echo "Run Aborted - $INIT_OK exists"  >> $LOG_FILE
   exit;
else
   /bin/echo "Starting ${STCODE}_Email_402_report.sh in ${ENV_CODE}."  >> $LOG_FILE
   rm -f $EMAIL_MESSAGE 
   /bin/touch $INIT_OK
fi
/bin/echo "Email_402_report - Init File touched: $INIT_OK" >> $LOG_FILE

#is the report file still open? Don't email until it closes
x=1
while [[ $x -gt 0 ]]
do
   x=$( lsof -Fn ${MAXDAT_ETL_PATH}/working/"${RPT_FILE}" | wc -l )
   sleep 1
done

/bin/echo "Email_402_report - Sending $RPT_FILE with the following cmd" >> $LOG_FILE
/bin/echo "Email_402_report - mutt -a ${MAXDAT_ETL_PATH}/working/${RPT_FILE} -s $RPT_FILE -- $EMAIL < /dev/null" >> $LOG_FILE

/usr/bin/mutt -a "${MAXDAT_ETL_PATH}/working/${RPT_FILE}" -s "$RPT_FILE" -- $EMAIL < /dev/null

rc=$?
/bin/echo "Email_402_report - mutt exit status: $rc" >> $LOG_FILE

if [[ $rc != 0 ]] ; then
        /bin/echo "exited with status: $rc - ${STCODE}_EMAIL_402_report.sh aborting run" >> $EMAIL_MESSAGE
        rm -f $INIT_OK
        /bin/mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
        /bin/echo "Email_402_report - Error Sending Report: $rc" >> $LOG_FILE
        exit $rc
fi
rm -f $INIT_OK
/bin/echo "Email_402_report - Script finished successfully, $INIT_OK file removed" >> $LOG_FILE



