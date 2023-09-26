#!/bin/bash
source /u01/maximus/maxdat-prd/FEDQIC/scripts/.set_env
#corp_run_bpm.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/FEDQIC/ETL/scripts/fedqic_run_instance_load.sh $
# $Revision: 10349 $
# $Date: 2014-06-02 18:29:15 -0500 (Mon, 02 Jun 2014) $
# $Author: dd27179 $
# =================================================================================
# This is the BPM Shell - it is setup to call all of the most common modules.  You
#   may delete what modules you don't want or you simply uncomment what you do want.
# =================================================================================
# ----------------------------------------------------------------
# Function for exit due to fatal program error
#    Accepts 1 argument: string containing descriptive error message
# ----------------------------------------------------------------
echo $KETTLE_HOME
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
# NOTE: The callable modules are marked with "#->".  Remove the "#->" to call the module. You may chose to delete
#       the lines you do not want entirely. Do not leave any "->" without a "#" or the script will error.
       	 $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MW/MW_Populate_Instance_Tables.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/MW_Populate_Instance_Tables_$(date +%Y%m%d_%H%M%S).log &
#->      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessMailFaxDoc/Process_mail_fax_doc_runall.kjb   $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/Process_mail_fax_doc_runall_$(date +%Y%m%d_%H%M%S).log &
#->      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessIncidents/Process_Incidents_RUN_ALL.kjb   $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/Process_Incidents_RUN_ALL_$(date +%Y%m%d_%H%M%S).log &
#->      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ManageJobs/ManageJobs_RunAll.kjb   $KJB_LOG_LEVEL    > $MAXDAT_ETL_LOGS/ManageJobs_RunAll_$(date +%Y%m%d_%H%M%S).log &
#->      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessLetters/Process_Letters_runall.kjb   $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/Process_Letters_runall_$(date +%Y%m%d_%H%M%S).log &
#->      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/SupportClientInquiry/ClientInquiry_Main_RUNALL.kjb   $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/ClientInquiry_Main_RUNALL_$(date +%Y%m%d_%H%M%S).log &
#->      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ManageEnrollmentActivity/ProcessManageEnroll_RUNALL_ONCE_A_DAY.kjb   $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/ManageEnroll_RUNALL_ONCE_A_DAY_$(date +%Y%m%d_%H%M%S).log &
#->      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ClientOutreach/ClientOutreach_runall.kjb   $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/ClientOutreach_runall_$(date +%Y%m%d_%H%M%S).log &
#->      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/CommunityOutreach/CommunityOutreach_RunAll.kjb   $KJB_LOG_LEVEL   > $MAXDAT_ETL_LOGS/CommunityOutreach_RunAll_$(date +%Y%m%d_%H%M%S).log &
#->      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/MissingInfo/ProcessMI_RUNALL.kjb   $KJB_LOG_LEVEL  > $MAXDAT_ETL_LOGS/ProcessMI_RUNALL_$(date +%Y%m%d_%H%M%S).log & 
#->      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProcessApplication/ProcessApp_RUNALL.kjb   $KTR_LOG_LEVEL  > $MAXDAT_ETL_LOGS/ProcessApp_RUNALL_$(date +%Y%m%d_%H%M%S).log & 
#->      $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/StateReview/ProcessStateReview_RUNALL.kjb   $KJB_LOG_LEVEL  > $MAXDAT_ETL_LOGS/ProcessStateReview_RUNALL_$(date +%Y%m%d_%H%M%S).log & 
#->        wait  #You only need this wait if you are running Prod Planning
#->        $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ProductionPlanning/PP_Actuals_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/PP_Actuals_RUNALL_$(date +%Y%m%d_%H%M%S).log &

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
