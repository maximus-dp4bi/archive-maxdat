#!/bin/bash
#. ~/.bash_profile
#run_bpm.sh
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
	exit 1
}

export KETTLE_HOME=$KETTLE_FL_HOME

#KTR_LOG_LEVEL='Basic'
KJB_LOG_LEVEL='Detailed'

#export PENTAHO_JAVA_HOME="/opt/tools/jdk1.7.0/jre/"
SCRIPTS_DIR="/home/pentaho/design-tools/data-integration"
#CUSTOM_DIR=$MAXDAT_ETL_DIR
#LOG_DIR=$MAXDAT_LOG_DIR
#LOG_LEVEL="Detailed"

INIT_OK="$MAXDAT_ETL_DIR/run_init_check.txt"
#CHILD_FAIL="/tmp/child_task_fail.txt"
BPM_RUN_CHECK_FILE=$INIT_OK

#mail related variables
EMAIL="spagadrai@Policy-Studies.com"
EMAIL_MESSAGE="/tmp/run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors with run_bpm.sh"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   exit;
else
   echo "Starting process letters."
   rm -f $EMAIL_MESSAGE 
   touch $INIT_OK
fi

#init check
#assumption that bpm_init_check.kjb and Run_Initiatization.kjb are present in $MAXDAT_ETL_DIR
$SCRIPTS_DIR/kitchen.sh -file="$MAXDAT_ETL_DIR/bpm_Init_check.kjb" -level="$LOG_LEVEL"  >> $MAXDAT_LOG_DIR/bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#creates run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
        echo "exited with status: $rc - bpm_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
		rm -f $INIT_OK
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
    exit $rc
else
#note misspelling
$MAXDAT_ETL_DIR/kitchen.sh -file="$MAXDAT_ETL_DIR/Run_Initialization.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_LOG_DIR/Run_Initialization.kjb_$(date +%Y%m%d_%H%M%S).log 
rc=$?
 if [[ $rc != 0 ]] ; then
                echo "Run_Initialization.kjb failed, aborting run" >> $EMAIL_MESSAGE
				rm -f $INIT_OK
                mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
                cat $EMAIL_MESSAGE
                exit $rc
   if [[ $? -eq 0 ]]
then
        $MAXDAT_ETL_DIR/kitchen.sh -file="$MAXDAT_ETL_DIR/ProcessLetters/Process_Letters_RUNALL.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_LOG_DIR/Process_Letters_RUNALL_$(date +%Y%m%d_%H%M%S).log &
		rc=$?
		if [[ $rc != 0 ]] ; then
                                #a child process failed, abort mission
                                echo "One or more process letters subtasks failed.  Check error logs for more details." >> $EMAIL_MESSAGE
								rm -f $INIT_OK
                                mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
                                cat $EMAIL_MESSAGE
								error_exit "$LINENO: Process Letters error has occurred."
                                #exit
else
                                #success, move on
                                echo "Process letters completed successfully."
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