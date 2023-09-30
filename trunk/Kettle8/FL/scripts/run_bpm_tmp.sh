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


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

#set up the environment
PATH=$KETTLE_FL_HOME/.kettle/kettle.properties:.:/home/pentaho/design-tools/data-integration:$PATH
export PATH
export KETTLE_HOME=$KETTLE_FL_HOME


export PENTAHO_JAVA_HOME="/opt/tools/jdk1.7.0/jre/"
SCRIPTS_DIR="/home/pentaho/design-tools/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_DIR
LOG_DIR=$MAXDAT_LOG_DIR
LOG_LEVEL="Detailed"

INIT_OK="$CUSTOM_DIR/run_init_check.txt"
CHILD_FAIL="/tmp/child_task_fail.txt"
BPM_RUN_CHECK_FILE=$INIT_OK

#mail related variables
EMAIL="phsmith@Policy-Studies.com, nvirdi@Policy-Studies.com"
EMAIL_MESSAGE="/tmp/run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors with run_bpm.sh"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#init check
#assumption that bpm_init_check.kjb and Run_Initiatization.kjb are present in $CUSTOM_DIR
$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/bpm_Init_check.kjb" -level="$LOG_LEVEL"  >> $LOG_DIR/bpm_init_check_$(date +%Y%m%d_%H%M%S).log
#creates run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
        echo "exited with status: $rc - bpm_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
    exit $rc
fi

if [[ $rc == 0 && -e $INIT_OK ]]
then
#note misspelling
#$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/Run_Initialization.kjb >> $LOG_DIR/Run_Initialization.kjb_$(date +%Y%m%d_%H%M%S).log 
    if [[ 0 -eq 0 ]]
    then 
        #ensure the directory structure matches and the desired kjb/ktr files are specified
        $CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ManageWork/ManageWork_RUNALL.kjb >> $LOG_DIR/ManageWork_RUNALL_$(date +%Y%m%d_%H%M%S).log &
        #$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/MemberEligibility/MemberEligibilty_RunAll.kjb >>  $LOG_DIR/MemberEligibilty_RunAll_$(date +%Y%m%d_%H%M%S).log &
        #  Renewals not to be setup until a couple of months after go-live
        #        $CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/InitiateRenewals/InitiateRenewals_Runall.kjb >> $LOG_DIR/InitiateRenewals_Runall_$(date +%Y%m%d_%H%M%S).log &
        #$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ProcessLetters/Process_Letters_RUNALL.kjb >> $LOG_DIR/Process_Letters_RUNALL_$(date +%Y%m%d_%H%M%S).log &
        #$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ProcessApplications/Process_Applications_RUNALL.kjb >> $LOG_DIR/Process_Applications_RUNALL__$(date +%Y%m%d_%H%M%S).log &
        if [[ -e $CHILD_FAIL ]]
        then
           #a child process failed, abort mission
             echo "One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> $EMAIL_MESSAGE
           mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
           cat $EMAIL_MESSAGE
           rm -f $INIT_OK
           #exit
           error_exit "$LINENO: An error has occurred."
        else
           #success, move on
           echo "Child processes completed successfully."
           rm -f $INIT_OK
           exit 0
        fi
         else
            #mail something went wrong with the init
            echo "Run_Initialization.kjb failed, review error log for additional detail." >> $EMAIL_MESSAGE
            mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
            at $EMAIL_MESSAGE
            rm -f $INIT_OK
            #exit
            error_exit "$LINENO: An error has occurred."
         fi 
else
#mail here, it didn't work, no connectivity
echo "bpm_init_check.kjb failed, review error log for additional detail." >> $EMAIL_MESSAGE
mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
cat $EMAIL_MESSAGE
error_exit "$LINENO: An error has occurred. run_bpm.sh"
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
