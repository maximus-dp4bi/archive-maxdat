#!/bin/bash
#. ~/.bash_profile
location='/u01/maximus/maxdat/CAHCO8/config'
source ${location}/.set_env
#product_run_instance_load.sh
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


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	#rm -f ${INIT_OK}
	exit 1
}
#
#
#
# Echo Environment Variables
echo "STCODE=$STCODE"
echo "MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH"
echo "MAXDAT_ETL_LOGS=$MAXDAT_ETL_LOGS"
echo "ENV_CODE=$ENV_CODE"
#
#export KETTLE_HOME=$KETTLE_NYHIX_HOME
#
KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
KJB_LOG_ROWLEVEL="Rowlevel"
#INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_instance_check.txt"
#INIT_BPM_OK="$MAXDAT_ETL_PATH/${STCODE}_run_check.txt"
CHILD_FAIL="/tmp/${STCODE}_child_task_instance_fail.txt"
CHILD_BPM_FAIL="/tmp/${STCODE}_child_task_fail.txt"
#
#
#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_run_instance_load-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_instance_check.sh in $ENV_CODE"
EMAIL_BPM_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
#
#checking for run file, Abort if it exists, create if it does not exists
#if [[ -e $INIT_BPM_OK ]] ; then
#   echo "Run Aborted - $INIT_OK exists"
#   exit;
#else
#   rm -f $EMAIL_BPM_MESSAGE $CHILD_BPM_FAIL
#fi

#if [[ -e $INIT_OK ]] ; then
#   echo "Run Aborted - $INIT_OK exists"
#   exit;
#else
#   echo "Starting ${STCODE}_run_instance_load.sh in ${ENV_CODE}."
#   rm -f $EMAIL_MESSAGE $CHILD_FAIL
#   touch $INIT_OK
#fi
#
#init check
MODULE=${MODULE_INIT}; RUN_FILE=bpm_Init_check; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_KETTLE_DIR}/kitchen.sh -file="${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb" -level="${KJB_LOG_LEVEL}"  >> ${LOG_FILE}
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - BPM_Init_check.kjb, aborting run in ${STCODE}" >> ${EMAIL_MESSAGE}
	#rm -f ${INIT_OK}
	mail -s "${EMAIL_SUBJECT}" "${EMAIL}" < ${EMAIL_MESSAGE}
	cat ${EMAIL_MESSAGE}
	exit $rc
else
   MODULE=${MODULE_MW};RUN_FILE=MW_Populate_Instance_Tables; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_ETL_PATH}/run_kjb.sh ${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb ${KJB_LOG_LEVEL} >> ${LOG_FILE}
   
   if [[ $? != 0 ]]
   then
	#mail something went wrong with the init
	echo "${RUN_FILE}.kjb failed in ${STCODE}, review error log for additional detail." >> ${EMAIL_MESSAGE}
	#rm -f ${INIT_OK}
	mail -s "${EMAIL_SUBJECT}" "${EMAIL}" < ${EMAIL_MESSAGE}
	cat ${EMAIL_MESSAGE}
	error_exit "${LINENO}: ${STCODE} - An Init error has occurred." 
   else
	#success, move on
	echo "$STCODE - Child processes completed successfully."
	#rm -f $INIT_OK
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
