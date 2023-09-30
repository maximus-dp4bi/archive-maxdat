#!/bin/bash
#. ~/.bash_profile
location='/u01/maximus/maxdat/LAEB/config'
source ${location}/.set_env
#product_run_bpm.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/LAEB/scripts/LAEB_run_emrs_selections.sh $
# $Revision: 30880 $
# $Date: 2020-09-22 12:57:14 -0700 (Tue, 22 Sep 2020) $
# $Author: aa24065 $
PROGNAME=$(basename $0 .sh)
SYNCH_INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_synch_slct_check.txt"
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	rm -f ${SYNCH_INIT_OK}
	exit 1
}

# The default log level variables are set in the .set_env.txt for all runs
# They can be overridden by uncommenting, removing the '#', for any variables below 
# KTR_LOG_LEVEL='Basic'
# KJB_LOG_LEVEL='Detailed'
# KJB_LOG_LEVEL='Rowlevel'


#mail related variables
EMAIL='MAXDatSystem@maximus.com'
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm.sh in ${ENV_CODE}"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e ${SYNCH_INIT_OK} ]] ; then
   echo "Run Aborted - ${SYNCH_INIT_OK} exists on ${ENV_CODE}."
   exit;
else
   echo "Starting ${STCODE}_run_bpm.sh on ${ENV_CODE}."
   rm -f ${EMAIL_MESSAGE} ${CHILD_FAIL}
   touch ${SYNCH_INIT_OK}
fi

# Current Module Names (for reference) the list is maintained in the ${KETTLE_HOME}/.set_env.txt file
# export MODULE_MW=MW
# export MODULE_MFB=MailFaxBatch
# export MODULE_MFD=MailFaxDoc
# export MODULE_PP=ProductionPlanning
# export MODULE_CC=ContactCenter
# export MODULE_IDR=IDR
# export MODULE_APL=Appeals
# export MODULE_PL=ProcessLetters
# export MODULE_PC=ProcessComplaints
# export MODULE_INIT=Initialization
# export MODULE_EMRS=EMRS


# Ensure the directory structure matches and the desired kjb/ktr files are specified
# Set the RUN_FILE to the kjb name (minus .kjb) and the MODULE the appropriate MODULE name.

#init check
MODULE=${MODULE_INIT}; RUN_FILE=bpm_Init_check; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_KETTLE_DIR}/kitchen.sh -file="${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb" -level="${KJB_LOG_LEVEL}"  >> ${LOG_FILE}
rc=$?
if [[ $rc != 0 ]] ; then
	echo "exited with status: $rc - BPM_Init_check.kjb, aborting run in ${STCODE}" >> ${EMAIL_MESSAGE}
	rm -f ${SYNCH_INIT_OK}
	mail -s "${EMAIL_SUBJECT}" "${EMAIL}" < ${EMAIL_MESSAGE}
	cat ${EMAIL_MESSAGE}
	exit $rc
else
         MODULE=${MODULE_EMRS}; RUN_FILE=ETL_Load_SELECTION_SEGMENT; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_ETL_PATH}/run_kjb.sh ${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb ${KJB_LOG_LEVEL} >> ${LOG_FILE} &
wait
         MODULE=${MODULE_EMRS}; RUN_FILE=ETL_Synchronize_SELECTION_SEGMENT; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_ETL_PATH}/run_kjb.sh ${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb ${KJB_LOG_LEVEL} >> ${LOG_FILE} &
wait
	if [[ -e ${CHILD_FAIL} ]]
		then
			#a child process failed, abort mission
			echo "${STCODE} - One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> ${EMAIL_MESSAGE}
			mail -s "${EMAIL_SUBJECT}" "${EMAIL}" < ${EMAIL_MESSAGE}
			cat ${EMAIL_MESSAGE}
			rm -f ${SYNCH_INIT_OK}
			#exit
			error_exit "${LINENO}: ${STCODE} - A Child error has occurred."
		else
			#success, move on
			echo "${STCODE} - Child processes completed successfully."
			rm -f ${SYNCH_INIT_OK}
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
