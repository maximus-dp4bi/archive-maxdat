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

INIT_OK="$LOG_DIR/run_init_check_daily.txt"
CHILD_FAIL="/tmp/daily_child_task_fail.txt"
BPM_RUN_CHECK_FILE=$INIT_OK

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors with Florida reload staging"

rm -f $EMAIL_MESSAGE $CHILD_FAIL
$CUSTOM_DIR/run_kjb.sh $CUSTOM_DIR/MailFaxBatch/MailFaxBatch_Stg_kfdocdata.kjb >> $LOG_DIR/MailFaxBatch_load_temptable_$(date +%Y%m%d_%H%M%S).log &
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
