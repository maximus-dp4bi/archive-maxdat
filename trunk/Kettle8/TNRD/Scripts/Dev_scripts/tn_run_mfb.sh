#!/bin/bash
#set -x
source /opt/maximus/maxdat-prd/TNRD/scripts/.set_env

#tn_run_mfb.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/TNRD/scripts/tn_run_mfb.sh $
# $Revision: 23129 $
# $Date: 2018-04-24 17:22:35 -0400 (Tue, 24 Apr 2018) $
# $Author: ps71980 $
# =================================================================================
# This is the MFB Shell - it is setup to call all of the most common modules.  You
#   may delete what modules you don't want or you simply uncomment what you do want.
# =================================================================================
# ----------------------------------------------------------------
# Function for exit due to fatal program error
#    Accepts 1 argument: string containing descriptive error message
# ----------------------------------------------------------------
PROGNAME=$(basename $0 .sh)
function error_exit
{
   echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
   rm -f $INIT_MFB_OK
   exit 1
}

# Checking for run file - Abort if it exists, otherwise create it
if [[ -e $INIT_MFB_OK ]] ; then
   echo "Run Aborted - $INIT_MFB_OK exists"
   exit;
else
   echo "Starting ${STCODE}_run_mfb.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_MFB_OK
fi

# Run the Init Check to see if resources are available
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/${STCODE}_mfb_init_check_$(date +%Y%m%d_%H%M%S).log
#
# Check the return value from Init Check - if it's not good (not 0), email error
rc=$?
if [[ $rc != 0 ]] ; then
   echo "exited with status: $rc - ${STCODE}_BPM_Init_check.kjb for MFB in ${ENV_CODE}, aborting run" >> $EMAIL_MESSAGE
   rm -f $INIT_MFB_OK
   mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
   cat $EMAIL_MESSAGE
   exit $rc
else
   # When the return code is 0, then run the Run Intailization
         $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MailFaxBatch/MailFaxBatch_RUNALL.kjb  $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/MailFaxBatch_runall_$(date +%Y%m%d_%H%M%S).log & wait
   # Checking the return value from MailFaxBatch_RUNALL - if 0, Sucesse.  If not 0, email error
   if [[ $? -eq 0 ]] ; then
      #success, move on
      echo "$STCODE - Child processes completed successfully."
      rm -f $INIT_MFB_OK
      exit 0
   else
      # Mail that something went wrong with the init and remove run check file
      echo "MailFaxBatch_RUNALL.kjb failed in ${STCODE}EB, review error log for additional detail." >> $EMAIL_MESSAGE
      rm -f $INIT_MFB_OK
      mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
      cat $EMAIL_MESSAGE
      error_exit "$LINENO: An error has occurred."
   fi
fi

#pan status codes
# 0     The transformation ran without a problem.
# 1     Errors occurred during processing
# 2     An unexpected error occurred during loading / running of the transformation
# 3     Unable to prepare and initialize this transformation
# 7     The transformation couldn't be loaded from XML or the Repository
# 8     Error loading steps or plugins (error in loading one of the plugins mostly)
# 9     Command line usage printing

#kitchen status codes
# 0     The job ran without a problem.
# 1     Errors occurred during processing
# 2     An unexpected error occurred during loading or running of the job
# 7     The job couldn't be loaded from XML or the Repository
# 8     Error loading steps or plugins (error in loading one of the plugins mostly)
# 9     Command line usage printing


