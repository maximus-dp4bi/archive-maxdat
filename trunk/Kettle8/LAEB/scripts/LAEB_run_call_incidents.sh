#!/bin/bash
location='/u01/maximus/maxdat/LAEB/config'
source ${location}/.set_env
PROGNAME=$(basename $0 .sh)
CRMPI_INIT_OK="$MAXDAT_ETL_PATH/LAEB_run_crmpi_check.txt"
function error_exit
{
#       ----------------------------------------------------------------
#       Function for exit due to fatal program error
#               Accepts 1 argument:  string containing descriptive error message
#       ----------------------------------------------------------------
        echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
        rm -f "${CRMPI_INIT_OK}"
        exit 1
}
#mail related variables
EMAIL='MAXDatSystem@maximus.com'
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm.sh in ${ENV_CODE}"
RUN_FILE="bpm_Init_check"
#checking for run file, Abort if it exists, create if it does not exists
#
if [[ -e "${CRMPI_INIT_OK}" ]]
then
   echo "Run Aborted - ${CRMPI_INIT_OK} exists on ${ENV_CODE]"
   exit
else
   echo "Starting ${STCODE}_run_bpm.sh On ${ENV_CODE}."
   rm -f "${EMAIL_MESSAGE}" "${CHILD_FAIL}"
   touch "${CRMPI_INIT_OK}"
fi
# Ensure the directory structure matches and the desired kjb/ktr files are specified
# Set the RUN_FILE  and the MODULE the appropriate MODULE name.
## check connections
MODULE="${MODULE_INIT}"
RUN_FILE=bpm_Init_check
LOG_NAME="${RUN_FILE}_(date +%Y%m%d_%H%M%S).log"
LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"
${MAXDAT_KETTLE_DIR}/kitchen.sh -file="${MAXDAT_ETL_PATH}"/"${MODULE}"/"${RUN_FILE}.kjb"  -level="${KJB_LOG_LEVEL}"  >> "${LOG_FILE}"
rc=$?
if [[ $rc != 0 ]] ; then
        echo "exited with status: $rc - BPM_Init_check.kjb, aborting run in ${STCODE}" >> "${EMAIL_MESSAGE}"
        rm -f $"CRMPI_INIT_OK}"
        mail -s "${EMAIL_SUBJECT}" "${EMAIL}" < "${EMAIL_MESSAGE}"
        cat "${EMAIL_MESSAGE}"
        exit $rc
else
   MODULE="${MODULE_CRI}"
   RUN_FILE="CR_Load_CallRecords_Incidents"
   LOG_NAME="${RUN_FILE}"_"$(date +%Y%m%d_%H%M%S)".log
   LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"
#   ${MAXDAT_ETL_PATH}/run_kjb.sh "${MAXDAT_ETL_PATH}"/"${MODULE}"/"${RUN_FILE}".kjb" ${KJB_LOG_LEVEL}" >> "${LOG_FILE}"
${MAXDAT_KETTLE_DIR}/kitchen.sh -file="${MAXDAT_ETL_PATH}"/"${MODULE}"/"${RUN_FILE}.kjb"  -level="${KJB_LOG_LEVEL}"  >> "${LOG_FILE}"
   if [[ -e "${CHILD_FAIL}" ]]
   then
        ####a child process failed, abort mission
        echo "${STCODE} - One or more subtasks failed.  Check error logs and ${CHILD_FAIL} for more details." >> "${EMAIL_MESSAGE}"
        mail -s "${EMAIL_SUBJECT}" "${EMAIL}" < "${EMAIL_MESSAGE}"
        cat "${EMAIL_MESSAGE}"
        rm -f $"{CRMPI_INIT_OK}"
        exit
        error_exit "${LINENO}: ${STCODE} - A Child error has occurred."
   else
      #success, move on
      echo "${STCODE} - Child processes completed successfully."
      rm -f "${CRMPI_INIT_OK}"
      exit 0
   fi
fi