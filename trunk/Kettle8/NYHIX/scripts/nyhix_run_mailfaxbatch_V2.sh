#!/bin/ksh
#. ~/.bash_profile
#nyhix_run_mailfaxbatch.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/NYHIX/ETL/scripts/nyhix_run_mailfaxbatch.sh $
# $Revision: 14190 $
# $Date: 2015-04-24 10:36:25 -0700 (Fri, 24 Apr 2015) $
# $Author: pa28085 $
PROGNAME=$(basename $0 .sh)

location='/u01/maximus/maxdat/NYHIX8/config'
source ${location}/.set_env


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

# MFB_OK is also part of the run init check kjb job
MFB_OK="$MAXDAT_ETL_PATH/${STCODE}_run_mailfaxbatch_V2_check.txt"
#MFB_FAIL="$MAXDAT_ETL_PATH/${STCODE}_child_mailfaxbatch_fail.txt"

#mail related variables
EMAIL='MAXDatSystem@maximus.com'
EMAIL_MESSAGE="/tmp/${2}_${STCODE}-ERROR-LOG.txt"
EMAIL_SUBJECT="${ENV_CODE}-${STCODE}-Errors With $2"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $MFB_OK ]] ; then
   echo "Run Aborted - $MFB_OK exists"
   exit;
else
   echo "Starting ${STCODE}_run_mailfaxbatch_V2.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE 
   touch $MFB_OK
   if [[ -e $MFB_OK ]] ; then
        echo " $MFB_OK Successfully created!!"
   else
        echo " $MFB_OK Was not Created"
   fi
fi

#   $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/${MODULE_MFB_V2}/MailFaxBatch_V2_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/${MODULE_MFB}/MailFaxBatch_RUNALL_V2_$(date +%Y%m%d_%H%M%S).log &
    $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/${MODULE_MFB_V2}/MailFaxBatch_V2_RUNALL.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/${MODULE_MFB_V2}/MailFaxBatch_RUNALL_V2_$(date +%Y%m%d_%H%M%S).log &
 
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
