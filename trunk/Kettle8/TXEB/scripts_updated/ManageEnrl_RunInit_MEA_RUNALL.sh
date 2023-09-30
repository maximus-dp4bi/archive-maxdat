#!/bin/ksh
. /dtxe4t/ETL_Scripts/scripts8/.set_env
#run_bpm.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/tx_run_bpm.sh $
# $Revision: 4462 $
# $Date: 2013-08-07 16:34:31 -0500 (Wed, 07 Aug 2013) $
# $Author: bt25944 $
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
        rm -f $INIT_OK
	exit 1
}

export BPM_RUN_CHECK_FILE=tx_bmp_check.txt

INIT_OK="$MAXDAT_ETL_PATH/tx_run_init_check.txt"
CHILD_FAIL="/tmp/tx_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/tx_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With tx_run_bpm.sh"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#init check
#assumption that bpm_init_check.kjb and Run_Initiatization.kjb are present in $CUSTOM_DIR
ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/tx_bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#creates tx_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - TX bpm_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
        rm -f $INIT_OK
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
    exit $rc
fi
if [[ $rc == 0 ]] #&& -e $INIT_OK ]]
then
ksh $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ManageEnrl_Run_Initialization.kjb Run_Initialization  >> $MAXDAT_ETL_LOGS/TX_MEA_Run_Initialization_$(date +%Y%m%d_%H%M%S).log
   if [[ $? -eq 0 ]]
   then 
      #ensure the directory structure matches and the desired kjb/ktr files are specified
      #$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/ManageWork/ManageWork_RUNALL.kjb ManageWork_RUNALL >> $MAXDAT_ETL_LOGS/ManageWork_RUNALL_$(date +%Y%m%d_%H%M%S).log &
      wait
      if [[ -e $CHILD_FAIL ]]
         then
            #a child process failed, abort mission
            echo "TX - One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> $EMAIL_MESSAGE
            mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
            cat $EMAIL_MESSAGE
            rm -f $INIT_OK
            #exit
            error_exit "$LINENO: An error has occurred."
         else
            success, move on
            echo "Child processes completed successfully."
            rm -f $INIT_OK
            exit 0
      fi	
   else
      #mail something went wrong with the init
      echo "Run_Initialization.kjb failed in TXEB, review error log for additional detail." >> $EMAIL_MESSAGE
      mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
      cat $EMAIL_MESSAGE
      rm -f $INIT_OK
      #exit
      error_exit "$LINENO: An error has occurred."
   fi 
else
#mail here, it didn't work, no connectivity
echo "bpm_init_check.kjb failed in TXEB, review error log for additional detail." >> $EMAIL_MESSAGE
mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
cat $EMAIL_MESSAGE
error_exit "$LINENO: An error has occurred in TXEB. run_bpm.sh"
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
