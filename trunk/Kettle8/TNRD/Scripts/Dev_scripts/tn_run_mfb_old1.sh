#!/bin/bash
#set -x
echo "Sourcing the env"
source $MD_SETENV

#corp_run_bpm.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TNRD/scripts/tn_run_bpm.sh $
# $Revision: 16809 $
# $Date: 2016-03-16 11:27:49 -0700 (Wed, 16 Mar 2016) $
# $Author: aa24065 $
# =================================================================================
# This is the BPM Shell - it is setup to call all of the most common modules.  You
#   may delete what modules you don't want or you simply uncomment what you do want.
# =================================================================================
# ----------------------------------------------------------------
# Function for exit due to fatal program error
#    Accepts 1 argument: string containing descriptive error message
# ----------------------------------------------------------------
echo "PROGNAME - FUNCTION ERROR_EXIT"
PROGNAME=$(basename $0 .sh)
function error_exit
{
   echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
   rm -f $INIT_MFB_OK
   exit 1
}

# Checking for run file - Abort if it exists, otherwise create it
echo "Checking for run file"
if [[ -e $INIT_MFB_OK ]] ; then
   echo "Run Aborted - $INIT_MFB_OK exists"
   exit;
else
   echo "Starting ${STCODE}_tn_run_mfb.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_MFB_OK
fi

echo "Running the Init Check"
# Run the Init Check to see if resources are available
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/${STCODE}_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#
# Check the return value from Init Check - if it's not good (not 0), email error
echo "rc"
rc=$?
if [[ $rc != 0 ]] ; then
   echo "exited with status: $rc - ${STCODE}_BPM_Init_check.kjb in ${ENV_CODE}, aborting run" >> $EMAIL_MESSAGE
   rm -f $INIT_MFB_OK
   mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
   cat $EMAIL_MESSAGE
   exit $rc
else
   # When the return code is 0, then run the MailFaxBatch_RUNALL.kjb
   echo "Starting MFB"
#$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MailFaxBatch/MailFaxBatch_RUNALL.kjb  $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/MailFaxBatch_runall_$(date +%Y%m%d_%H%M%S).log &
   # Checking the return value from Run Intialization - if 0, run rest of code.  If not 0, email error
   if [[ $? -eq 0 ]]
   then
   echo "MailFaxBatch_RUNALL.kjb ran successfully"
# NOTE: The callable modules are marked with "#->".  Remove the "#->" to call the module. You may chose to delete
#       the lines you do not want entirely. Do not leave any "->" without a "#" or the script will error.
#	echo "Starting MFB"
	#      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MailFaxBatch/MailFaxBatch_RUNALL.kjb  $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/MailFaxBatch_runall_$(date +%Y%m%d_%H%M%S).log &

#        wait  #You only need this wait if you are running Prod Planning
#->        $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProductionPlanning/PP_Actuals_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/PP_Actuals_RUNALL_$(date +%Y%m%d_%H%M%S).log &
#        wait  #PP_Actuals_AHT_Staff_Hour_CADIR_RUNALL needs to wait for PP_Actuals_RUNALL to complete
#->	    $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProductionPlanning/PP_Actuals_AHT_Staff_Hour_CADIR_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/PP_Actuals_AHT_Staff_Hour_CADIR_RUNALL_$(date +%Y%m%d_%H%M%S).log &
#      wait
#      if [[ -e $CHILD_FAIL ]]
#         then
#            #a child process failed, abort mission
#            rm -f $INIT_OK
#            mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
#            cat $EMAIL_MESSAGE
#            error_exit "$LINENO: An error has occurred."
#         else
#            #success, move on
#            echo "$STCODE - Child processes completed successfully."
#            rm -f $INIT_OK
#            exit 0
#      fi	
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
# 0 	The transformation ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading / running of the transformation
# 3 	Unable to prepare and initialize this transformation
# 7 	The transformation couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing

#kitchen status codes
# 0 	The job ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading or running of the job
# 7 	The job couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing

