#!/bin/ksh
. ~/.bash_profile
#nyhix_run_mfd_v2.sh
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

#KTR_LOG_LEVEL='Basic'
KJB_LOG_LEVEL='Detailed'

# MFD_V2_OK is also part of the run init check kjb job
MFD_V2_OK="$MAXDAT_ETL_PATH/${STCODE}_run_mfd_v2_check.txt"
#MFD_FAIL="$MAXDAT_ETL_PATH/${STCODE}_child_MFD_fail.txt"

#mail related variables
EMAIL='MAXDatSystem@maximus.com'
EMAIL_MESSAGE="/tmp/${2}_${STCODE}-ERROR-LOG.txt"
EMAIL_SUBJECT="${STCODE}-Errors With $2"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $MFD_V2_OK ]] ; then
   echo "Run Aborted - $MFD_V2_OK exists"
   exit;
else
   echo "Starting ${STCODE}_run_mfd_v2.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE 
   touch $MFD_V2_OK
fi

#init check
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/mfd_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/mfd_v2_Init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
                echo "Exited with status: $rc - ${STCODE} MFD_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
                rm -f $MFD_V2_OK
                mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
                cat $EMAIL_MESSAGE
                exit $rc
else
   $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/Run_Initialization_MFD.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/Run_Initialization_MFD_$(date +%Y%m%d_%H%M%S).log
   rc=$?
   if [[ $rc != 0 ]] ; then
                echo "Exited with status: $rc - ${STCODE} Run_Initialization_MFD.kjb, aborting run" >> $EMAIL_MESSAGE
                rm -f $MFD_V2_OK
                mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
                cat $EMAIL_MESSAGE
                exit $rc
else
#   if [[ $? -eq 0 ]]
#  then
   $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/MailFaxDocV2/ProcessMailFaxDoc_Runall.Kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/ProcessMailFaxDoc_Runall_v2_$(date +%Y%m%d_%H%M%S).log
   rc=$?
   if [[ $rc != 0 ]] ; then
                                #a child process failed, abort mission
                                echo "$STCODE - One or more MFD V2 subtasks failed.  Check error logs for more details." >> $EMAIL_MESSAGE
                                rm -f $MFD_V2_OK
                                mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
                                cat $EMAIL_MESSAGE
                                #exit
                                error_exit "$LINENO: $STCODE - MFD V2 error has occurred."
   else
                                #success, move on
                                echo "$STCODE - MFD V2 processes completed successfully."
                                rm -f $MFD_V2_OK
                                exit 0
   fi      
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