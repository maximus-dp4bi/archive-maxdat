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
#PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_PATH/IL/ETL/scripts
LOG_DIR=$MAXDAT_ETL_PATH/IL/ETL/logs
ERR_DIR=$MAXDAT_ETL_PATH/IL/ETL/errors
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

INIT_OK="$CUSTOM_DIR/il_run_init_check.txt"
CHILD_FAIL="/tmp/il_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/il_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With il_run_bpm.sh"

$CUSTOM_DIR/run_ktr.sh /u01/maximus/maxdat-prd/IL/ETL/scripts/ManageEnrollmentActivity/ManageEnroll_Calc_Age.ktr >> /u01/maximus/maxdat-prd/IL/ETL/logs/ManageEnrollmentActivity/ONETIME_MANUAL_ManageEnroll_Calc_Age_$(date +%Y%m%d_%H%M%S).log

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
