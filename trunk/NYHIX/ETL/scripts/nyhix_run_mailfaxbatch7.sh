#!/bin/ksh
#. ~/.bash_profile
#nyhix_run_mailfaxbatch7.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$
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

# MFB_OK is also part of the run init check kjb job
MFB_OK="$MAXDAT_ETL_PATH/${STCODE}_run_mailfaxbatch_check.txt"
#MFB_FAIL="$MAXDAT_ETL_PATH/${STCODE}_child_mailfaxbatch_fail.txt"

#mail related variables
EMAIL='nickvirdi@maximus.com'
EMAIL_MESSAGE="/tmp/${2}_${STCODE}-ERROR-LOG.txt"
EMAIL_SUBJECT="${STCODE}-Errors With $2"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $MFB_OK ]] ; then
   echo "Run Aborted - $MFB_OK exists"
   exit;
else
   echo "Starting ${STCODE}_run_mailfaxbatch.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE 
   touch $MFB_OK
   if [[ -e $MFB_OK ]] ; then
        echo " $MFB_OK Successfully created!!"
   else
        echo " $MFB_OK Was not Created"
   fi
fi

$MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/MailFaxBatch/MailFaxBatch_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/MailFaxBatch_RUNALL_$(date +%Y%m%d_%H%M%S).log &
   wait
   
   rc=$?
   if [[ $rc != 0 ]] ; then
                                #a child process failed, abort mission
                                echo "$STCODE - One or more MailFaxBatch subtasks failed.  Check error logs for more details." >> $EMAIL_MESSAGE
                                rm -f $MFB_OK
                                mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
                                cat $EMAIL_MESSAGE
                                #exit
                                error_exit "$LINENO: $STCODE - MailFaxBatch error has occurred."
   else
                                #success, move on
                                echo "$STCODE - MailFaxBatch processes completed successfully."
                                rm -f $MFB_OK
                                exit 0
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
