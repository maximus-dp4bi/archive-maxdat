#!/bin/bash
. ~/.bash_profile
#il_run_bpm_7_1.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
	rm -f $INIT_OK
	exit 1
}

#Complete the environment - Specific to IL only
#---------------------------
export STCODE=IL
export ENV='dev'

export MAXDAT_KETTLE_DIR=/u01/app/appadmin/product/pdi-ce-7.1.0.0-12/data-integration
export KETTLE_IL_HOME="/u01/maximus/maxdat-$ENV/$STCODE/config"
export KETTLE_HOME=$KETTLE_IL_HOME
export MAXDAT_ETL_PATH="/u01/maximus/maxdat-$ENV/$STCODE/ETL"
export ILEB_REPORTS_OUTPUT_DIR="$MAXDAT_ETL_PATH/scripts/AgencyReports/working"

export JAVA_HOME="/u01/app/appadmin/product/java/jdk1.8.0_92"
export PENTAHO_JAVA_HOME=$JAVA_HOME
# export PENTAHO_JAVA=$JAVA_HOME/bin/java

export SCRIPTS_DIR=$MAXDAT_ETL_PATH/scripts
export LOGS_DIR=$MAXDAT_ETL_PATH/logs
export ERR_DIR=$MAXDAT_ETL_PATH/error
#--------------------------

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
KJB_LOG_LEVEL_DEBUG="Debug"
# INIT_OK="$SCRIPTS_DIR/${STCODE}_run_check.txt"
# CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm_7_1.sh in $ENV_CODE"

echo "Starting ${STCODE}_run_bpm_7_1.sh in ${ENV_CODE}."
# BPM init check
 $MAXDAT_KETTLE_DIR/kitchen.sh -file="$SCRIPTS_DIR/bpm_Init_check.kjb" -level="$KJB_LOG_LEVEL_DEBUG"  >> $LOGS_DIR/${STCODE}_bpm_init_check_PDI7_1_$(date +%Y%m%d_%H%M%S).log

rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - ${STCODE}_BPM_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
	exit $rc
else
echo "Starting ProcessLetters_RUNALL_ONCE_A_DAY.kjb"
	#$SCRIPTS_DIR/run_kjb_7_1.sh $SCRIPTS_DIR/ProcessLetters/ProcessLetters_RUNALL_ONCE_A_DAY.kjb $KJB_LOG_LEVEL >> $LOGS_DIR/Process_Letters_runall_PDI7_1_$(date +%Y%m%d_%H%M%S).log &
  
fi

echo "Finished ${STCODE}_run_bpm_7_1.sh in ${ENV_CODE}."
exit 0