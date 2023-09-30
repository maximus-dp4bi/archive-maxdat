#!/bin/bash
#set -x
source $MD_SETENV

#corp_run_bpm.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/TNRD/scripts/tn_run_bpm_uat.sh $
# $Revision: 22633 $
# $Date: 2018-03-02 08:46:06 -0800 (Fri, 02 Mar 2018) $
# $Author: aa24065 $
# =================================================================================
# This is the BPM Shell - it is setup to call all of the most common modules.  You
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
   rm -f $INIT_OK
   exit 1
}

# Checking for run file - Abort if it exists, otherwise create it
if [[ -e $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   exit;
else
   echo "Starting ${STCODE}_run_bpm.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_OK
fi

# Run the Init Check to see if resources are available
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/${STCODE}_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#
# Check the return value from Init Check - if it's not good (not 0), email error
rc=$?
if [[ $rc != 0 ]] ; then
   echo "exited with status: $rc - ${STCODE}_BPM_Init_check.kjb in ${ENV_CODE}, aborting run" >> $EMAIL_MESSAGE
   rm -f $INIT_OK
   mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
   cat $EMAIL_MESSAGE
   exit $rc
else
   # When the return code is 0, then run the Run Intailization
   $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/Run_Initialization.kjb $KJB_LOG_LEVEL > $MAXDAT_ETL_LOGS/${STCODE}_Run_Initialization_$(date +%Y%m%d_%H%M%S).log
   # Checking the return value from Run Intialization - if 0, run rest of code.  If not 0, email error
   if [[ $? -eq 0 ]]
   then
# NOTE: The callable modules are marked with "#->".  Remove the "#->" to call the module. You may chose to delete
#       the lines you do not want entirely. Do not leave any "->" without a "#" or the script will error.
      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MW_V2/MW_V2_RUNALL_TIMER.kjb  $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/MW_V2_RUNALL_TIMER_$(date +%Y%m%d_%H%M%S).log &
      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessLetters/ProcessLetters_RUNALL_ONCE_A_DAY.kjb  $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/ProcessLetters_RUNALL_ONCE_A_DAY_$(date +%Y%m%d_%H%M%S).log &
      #$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MailFaxBatch/MailFaxBatch_RUNALL.kjb  $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/MailFaxBatch_runall_$(date +%Y%m%d_%H%M%S).log &
$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/AgencyReports/RedeterminationProcessing/TN_Redet_Processing_Job.kjb  $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/TN_Redet_Processing_Job_$(date +%Y%m%d_%H%M%S).log &
$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/AgencyReports/ManualCallRecord/TN_ManualCallRecord_Job.kjb  $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/TN_ManualCallRecord_Job_$(date +%Y%m%d_%H%M%S).log &
#$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/DocumentMonitoring/TN_DocumentMonitoring_Job.kjb $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/TN_DocumentMonitoring_Job_$(date +%Y%m%d_%H%M%S).log &

        wait
$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/AgencyReports/CIR_Incremental/TN_CIR_GetIncremental_Data.kjb  $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/TN_CIR_GetIncremental_Data_$(date +%Y%m%d_%H%M%S).log &

#You only need this wait if you are running Prod Planning
#->        $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProductionPlanning/PP_Actuals_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/PP_Actuals_RUNALL_$(date +%Y%m%d_%H%M%S).log &
        wait  #PP_Actuals_AHT_Staff_Hour_CADIR_RUNALL needs to wait for PP_Actuals_RUNALL to complete
#->	    $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProductionPlanning/PP_Actuals_AHT_Staff_Hour_CADIR_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/PP_Actuals_AHT_Staff_Hour_CADIR_RUNALL_$(date +%Y%m%d_%H%M%S).log &
      wait
      if [[ -e $CHILD_FAIL ]]
         then
            #a child process failed, abort mission
            rm -f $INIT_OK
            mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
            cat $EMAIL_MESSAGE
            error_exit "$LINENO: An error has occurred."
         else
            #success, move on
            echo "$STCODE - Child processes completed successfully."
            rm -f $INIT_OK
            exit 0
      fi	
   else
      # Mail that something went wrong with the init and remove run check file
      echo "Run_Initialization.kjb failed in ${STCODE}EB, review error log for additional detail." >> $EMAIL_MESSAGE
      rm -f $INIT_OK
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
