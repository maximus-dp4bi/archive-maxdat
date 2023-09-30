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

CHILD_FAIL="/tmp/daily_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors with Florida run_bpm.sh daily"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#iniEgibilty_RunAll.kjb check
#assumption that bpm_init_check.kjb and Run_Initiatization.kjb are present in $CUSTOM_DIR
$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/bpm_daily_Init_check.kjb" -level="$LOG_LEVEL"  >> $LOG_DIR/bpm_daily_init_check_$(date +%Y%m%d_%H%M%S).log
#creates run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
        echo "exited with status: $rc - bpm_Init_daily_check.kjb, aborting run" >> $EMAIL_MESSAGE
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
    exit $rc
fi

#note misspelling
$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/Run_Initialization.kjb >> $LOG_DIR/Run_Initialization.kjb_$(date +%Y%m%d_%H%M%S).log 
        #ensure the directory structure matches and the desired kjb/ktr files are specified
$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/MemberEligibility/MemberEligibilty_RunAll.kjb >>  $LOG_DIR/MemberEligibilty_RunAll_$(date +%Y%m%d_%H%M%S).log &
$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/InitiateRenewals/InitiateRenewals_Runall.kjb >> $LOG_DIR/InitiateRenewals_Runall_$(date +%Y%m%d_%H%M%S).log &
$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/SupportMemberInquiry/SupportMemberInquiry_RUNALL.kjb >> $LOG_DIR/Support_Member_Inquiry_RUNALL_$(date +%Y%m%d_%H%M%S).log &
$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ProcessLetters/Process_Letters_RUNALL.kjb >> $LOG_DIR/Process_Letters_RUNALL_$(date +%Y%m%d_%H%M%S).log &
$CUSTOM_DIR/fl_run_emrs.sh &
$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/ProcessDocuments_V2/ProcessDocuments_V2_RUNALL.kjb >> $LOG_DIR/ProcessDocuments_V2_RUNALL_$(date +%Y%m%d_%H%M%S).log &
$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/MailFaxBatch/MailFaxBatch_Central_ARS_RUNALL.kjb >> $LOG_DIR/MailFaxBatch_Central_ARS_RUNALL_$(date +%Y%m%d_%H%M%S).log &
if [[ -e $CHILD_FAIL ]]
then
   #a child process failed, abort mission
   echo "One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> $EMAIL_MESSAGE
   mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
   cat $EMAIL_MESSAGE
   #exit
   error_exit "$LINENO: An error has occurred."
else
   #success, move on
   echo "Child processes completed successfully."
   exit 0
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
