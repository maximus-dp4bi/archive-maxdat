#!/bin/ksh
. ~/.profile
#tx_run_bpm.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/tx_run_bpm_daily.sh $
# $Revision: 15999 $
# $Date: 2015-12-11 13:50:40 -0800 (Fri, 11 Dec 2015) $
# $Author: aa24065 $
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

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_check_daily.txt"
CHILD_FAIL="/tmp/${STCODE}_daily_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm_daily-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm_daily7.sh in $ENV_CODE"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   exit;
else
   echo "Starting ${STCODE}_run_bpm_daily.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_OK
fi


ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/${STCODE}_bpm_daily_init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - ${STCODE}_BPM_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
	rm -f $INIT_OK
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
else
   $MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/Run_Initialization_Daily.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/${STCODE}_Run_Initialization_Daily_$(date +%Y%m%d_%H%M%S).log
 if [[ $? -eq 0 ]]
   then

      #ensure the directory structure matches and the desired kjb/ktr files are specified
      $MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/ProcessLetters/Process_Letters_runall.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Process_Letters_bpm_Let_runall_$(date +%Y%m%d_%H%M%S).log &
      $MAXDAT_ETL_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/ClientOutreach/ClientOutreach_runall.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/ClientOutreach_runall_$(date +%Y%m%d_%H%M%S).log &	

	  wait
      if [[ -e $CHILD_FAIL ]]
         then
            #a child process failed, abort mission
		echo "$STCODE - One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> $EMAIL_MESSAGE
		rm -f $INIT_OK
            mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
            cat $EMAIL_MESSAGE
            #exit
            error_exit "$LINENO: An error has occurred."
         else
           #success, move on
		echo "$STCODE - Daily Child processes completed successfully."
            rm -f $INIT_OK
            exit 0
      fi	
   else
      #mail something went wrong with the init
	echo "Run_Initialization.kjb failed in ${STCODE}EB, review error log for additional detail." >> $EMAIL_MESSAGE
	rm -f $INIT_OK
      mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
      cat $EMAIL_MESSAGE
      error_exit "$LINENO: An error has occurred."
   fi 
fi
