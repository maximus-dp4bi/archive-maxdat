#!/bin/bash
#. ~/.bash_profile
location='/u01/maximus/maxdat/CAHCO8/config'
source ${location}/.set_env
#product_run_bpm.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/CAHCO/scripts/CAHCO_run_bpm.sh $
# $Revision: 27330 $
# $Date: 2019-05-29 18:52:10 -0500 (Wed, 29 May 2019) $
# $Author: TM151500 $
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	rm -f ${INIT_OK}
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
if [[ -e ${INIT_OK} ]] ; then
   echo "Run Aborted - ${INIT_OK} exists"
   exit;
else
   echo "Starting ${STCODE}_run_bpm.sh in ${ENV_CODE}."
   rm -f ${EMAIL_MESSAGE} ${CHILD_FAIL}
   touch ${INIT_OK}
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
	rm -f ${INIT_OK}
	mail -s "${EMAIL_SUBJECT}" "${EMAIL}" < ${EMAIL_MESSAGE}
	cat ${EMAIL_MESSAGE}
	exit $rc
else
   MODULE=${MODULE_INIT};RUN_FILE=Run_Initialization; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_ETL_PATH}/run_kjb.sh ${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb ${KJB_LOG_LEVEL} >> ${LOG_FILE}
   if [[ $? -eq 0 ]]
   then
	 MODULE=${MODULE_MW}; RUN_FILE=MW_RUNALL; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_ETL_PATH}/run_kjb.sh ${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb ${KJB_LOG_LEVEL} >> ${LOG_FILE} &
	# MODULE=${MODULE_MFB}; RUN_FILE=MailFaxBatch_RUNALL; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_ETL_PATH}/run_kjb.sh ${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb ${KJB_LOG_LEVEL} >> ${LOG_FILE} &
	# MODULE=${MODULE_MFD}; RUN_FILE=Process_mail_fax_doc_runall; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_ETL_PATH}/run_kjb.sh ${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb ${KJB_LOG_LEVEL} >> ${LOG_FILE} &
    # MODULE=${MODULE_PC}; RUN_FILE=Process_Complaints_RUN_ALL; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_ETL_PATH}/run_kjb.sh ${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb ${KJB_LOG_LEVEL} >> ${LOG_FILE} &
    # MODULE=${MODULE_APL}; RUN_FILE=Process_Appeals_RUN_ALL; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_ETL_PATH}/run_kjb.sh ${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb ${KJB_LOG_LEVEL} >> ${LOG_FILE} &
	# MODULE=${MODULE_IDR}; RUN_FILE=IDR_Incidents_RUN_ALL; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_ETL_PATH}/run_kjb.sh ${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb $KJB_LOG_LEVEL >> ${LOG_FILE} &
	# wait
	 # MODULE=${MODULE_PP}; RUN_FILE=PP_Actuals_Process; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_ETL_PATH}/run_kjb.sh ${MAXDAT_ETL_PATH}/${MODULE}/Actuals_v3/${RUN_FILE}.kjb ${KJB_LOG_LEVEL} >> ${LOG_FILE} &
	  wait
		if [[ -e ${CHILD_FAIL} ]]
		then
			#a child process failed, abort mission
			echo "${STCODE} - One or more subtasks failed.  Check error logs and $CHILD_FAIL for more details." >> ${EMAIL_MESSAGE}
			mail -s "${EMAIL_SUBJECT}" "${EMAIL}" < ${EMAIL_MESSAGE}
			cat ${EMAIL_MESSAGE}
			rm -f ${INIT_OK}
			#exit
			error_exit "${LINENO}: ${STCODE} - A Child error has occurred."
		else
			#success, move on
			echo "${STCODE} - Child processes completed successfully."
			rm -f ${INIT_OK}
			exit 0
		fi	
	else
		#mail something went wrong with the init
		echo "Run_Initialization.kjb failed in ${STCODE}, review error log for additional detail." >> ${EMAIL_MESSAGE}
		rm -f ${INIT_OK}
		mail -s "${EMAIL_SUBJECT}" "${EMAIL}" < ${EMAIL_MESSAGE}
		cat ${EMAIL_MESSAGE}
		error_exit "${LINENO}: ${STCODE} - An Init error has occurred."
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
