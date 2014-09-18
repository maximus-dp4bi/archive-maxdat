#!/bin/bash
. ~/.bash_profile
#nyhix_run_load_process_metrics.sh
PROGNAME=$(basename $0 .sh)
function error_exit
{

#             ----------------------------------------------------------------
#             Function for exit due to fatal program error
#                             Accepts 1 argument:
#                                             string containing descriptive error message
#             ----------------------------------------------------------------


                echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
                exit 1
}

export KETTLE_HOME=$KETTLE_NYHIX_HOME

KJB_LOG_LEVEL='Detailed'

#mail related variables
EMAIL='MAXDatSystem@maximus.com'
EMAIL_MESSAGE="/tmp/${STCODE}-LOADMETRICS-ERROR-LOG.txt"
EMAIL_SUBJECT="${STCODE}-Errors With Load Metrics"

#init check
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/chart_Init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
                echo "Exited with status: $rc - ${STCODE} bpm_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
                mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
                cat $EMAIL_MESSAGE
                exit $rc
else
   $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/ProcessControlChart/load_ProcessMetrics.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/load_ProcessMetrics_$(date +%Y%m%d_%H%M%S).log
   rc=$?
   if [[ $rc != 0 ]] ; then
                                #a child process failed, abort mission
                                echo "$STCODE - One or more Chart tasks failed.  Check error logs for more details." >> $EMAIL_MESSAGE
                                mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
                                cat $EMAIL_MESSAGE
                                #exit
                                error_exit "$LINENO: $STCODE - chart error has occurred."
   else
                                #success, move on
                                echo "$STCODE - Chart processes completed successfully."
                                exit 0
   fi
fi

#pan status codes
# 0          The transformation ran without a problem.
# 1          Errors occurred during processing
# 2          An unexpected error occurred during loading / running of the transformation
# 3          Unable to prepare and initialize this transformation
# 7          The transformation couldn't be loaded from XML or the Repository
# 8          Error loading steps or plugins (error in loading one of the plugins mostly)
# 9          Command line usage printing

#kitchen status codes
# 0          The job ran without a problem.
# 1          Errors occurred during processing
# 2          An unexpected error occurred during loading or running of the job
# 7          The job couldn't be loaded from XML or the Repository
# 8          Error loading steps or plugins (error in loading one of the plugins mostly)
# 9          Command line usage printing