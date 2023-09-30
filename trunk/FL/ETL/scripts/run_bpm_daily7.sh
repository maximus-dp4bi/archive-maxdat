#!/bin/bash
. ~/.bash_profile
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
#PATH=$KETTLE_FL_HOME/.kettle/kettle.properties:.:/home/pentaho/design-tools/data-integration:$PATH
#export PATH
#export KETTLE_HOME=$KETTLE_FL_HOME
#export PENTAHO_JAVA_HOME="/opt/tools/jdk1.7.0/jre/"
SCRIPTS_DIR=$MAXDAT_KETTLE_DIR
CUSTOM_DIR=$MAXDAT_ETL_DIR
LOG_DIR=$MAXDAT_LOG_DIR
LOG_LEVEL="Detailed"
source $CUSTOM_DIR/.setenv_var7

CHILD_FAIL="/tmp/daily_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors with Florida run_bpm.sh daily"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#assumption that bpm_init_check.kjb in $CUSTOM_DIR
$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/bpm_daily_Init_check.kjb" -level="$LOG_LEVEL"  >> $LOG_DIR/bpm_daily_init_check_$(date +%Y%m%d_%H%M%S).log
#creates run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
        echo "exited with status: $rc - bpm_Init_daily_check.kjb, aborting run" >> $EMAIL_MESSAGE
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
    exit $rc
fi
$CUSTOM_DIR/run_kjb7.sh $CUSTOM_DIR/MailFaxBatch7/MailFaxBatch7_Central_Kofax_Extract.kjb >> $LOG_DIR/MailFaxBatch7_Central_Kofax_Extract_RUNALL_$(date +%Y%m%d_%H%M%S).log 
if [[ -e $CHILD_FAIL ]] ; then
   #a child process failed, abort mission
   echo "One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> $EMAIL_MESSAGE
   mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
   cat $EMAIL_MESSAGE
   #exit
   error_exit "$LINENO: An error has occurred."
fi
if [[ ! -e $LOG_DIR/MailFaxBatch7_done.txt ]] ; then
     #success, move on
     $CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/MailFaxBatch/MailFaxBatch_Central_Updates.kjb >> $LOG_DIR/MailFaxBatch_Central_Updates_$(date +%Y%m%d_%H%M%S).log 
     exit 0
fi
exit 0
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
