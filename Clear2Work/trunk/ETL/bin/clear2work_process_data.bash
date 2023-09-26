#!/bin/bash

# Clear2Work - Process Data script

# Trap and write command causing error.
error_handling () {
    ERROR_CODE=$?
    echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: `basename "$0"` line ${BASH_LINENO[0]} failed to run '${BASH_COMMAND}'."
    exit $ERROR_CODE
}
trap error_handling ERR

#
echo " "			
echo " "
echo "clea2work_process_data.bash execution started : $(date +"%Y%m%d_%H%M%S_%3N")"

location='/u01/maximus/maxdat/AMP_ETL/Config'
source ${location}/.set_env

DB_COLUMN_SEPARATOR=';'
EMAIL_SUBJECT="Clear2Work_process_data.bash - ${ENV_CODE} - FAILURE NOTIFICATION"
EMAIL_TO_LIST="maxdatsystem@maximus.com"

# Get database access variables from properties file.
KETTLE_PROPERTIES_FILE=$KETTLE_HOME/.kettle/kettle.properties

DB_HOST=$(grep "^DB_MOTS_HOSTNAME" ${KETTLE_PROPERTIES_FILE} | cut -d'=' -f2)
DB_PORT=$(grep "^DB_MOTS_PORT" ${KETTLE_PROPERTIES_FILE} | cut -d'=' -f2)
DB_SERVICE=$(grep "^DB_MOTS_DATABASENAME" ${KETTLE_PROPERTIES_FILE} | cut -d'=' -f2)
DB_USERNAME=$(grep "^DB_MOTS_USER" ${KETTLE_PROPERTIES_FILE} | cut -d'=' -f2)

# If password is encrypted, decrypt it.. If not, take it as it is 
DB_PASSWORD=$(grep "^DB_MOTS_PASSWORD" ${KETTLE_PROPERTIES_FILE} | cut -d'=' -f2)
if [ "${DB_PASSWORD:0:9}" = "Encrypted" ]; then
	DB_ENCRYPTED_PASSWORD=$(grep "^DB_MOTS_PASSWORD" ${KETTLE_PROPERTIES_FILE} | cut -d'=' -f2 | cut -d' ' -f2)
	export CLASSPATH=$CLASSPATH:$Clear2Work_SCRIPT_DIR;
	DB_PASSWORD="$(bash $Clear2Work_SCRIPT_DIR/decr.sh $DB_ENCRYPTED_PASSWORD)"
fi

# Get Current time in YYYY_MM_DD_HH24_MI_SS_NNN
JOB_RUN_FILE_SUFFIX=$(date +"%Y%m%d_%H%M%S_%3N")

PROCESS_CLEAR2WORK_JOB_RESULTS_FILE=${Clear2Work_DATA_DIR}/process_clear2work_job_results_${JOB_RUN_FILE_SUFFIX}.dat
# Get job config from database.
${DB_CLIENT} -S ${DB_USERNAME}/${DB_PASSWORD}@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${Clear2Work_SQL_DIR}/process_clear2work_job.sql > ${PROCESS_CLEAR2WORK_JOB_RESULTS_FILE}

CLEAR2WORK_JOB_STATUS_RESULTS_FILE=${Clear2Work_DATA_DIR}/clear2work_job_status_results_${JOB_RUN_FILE_SUFFIX}.dat
# Get job config from database.
${DB_CLIENT} -S ${DB_USERNAME}/${DB_PASSWORD}@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${Clear2Work_SQL_DIR}/clear2work_job_status.sql > ${CLEAR2WORK_JOB_STATUS_RESULTS_FILE}

while read REPORT_CONFIG_ROW; do
	if [ "${REPORT_CONFIG_ROW}" != "" ]; then

		JOB_ID=$(echo ${REPORT_CONFIG_ROW} | cut -f1 -d${DB_COLUMN_SEPARATOR})
		JOB_STATUS=$(echo ${REPORT_CONFIG_ROW} | cut -f2 -d${DB_COLUMN_SEPARATOR})
		DESCRIPTION=$(echo ${REPORT_CONFIG_ROW} | cut -f3 -d${DB_COLUMN_SEPARATOR})
		JOB_BEGIN_DT=$(echo ${REPORT_CONFIG_ROW} | cut -f4 -d${DB_COLUMN_SEPARATOR})
		JOB_END_DT=$(echo ${REPORT_CONFIG_ROW} | cut -f5 -d${DB_COLUMN_SEPARATOR})
		
		ERROR_MSG="Status of the Job# ${JOB_ID} is ${JOB_STATUS} - ${DESCRIPTION}"
		echo $ERROR_MSG
		
		# In case of job failure, email to the team
		if [ "$JOB_STATUS" = "FAILED" ]; then
			EMAIL_DESCRIPTION="This is to notify that Job# ${JOB_ID} for clear2work_process_data.bash has failed in ${ENV_CODE}. ${DESCRIPTION}."
			echo ${EMAIL_DESCRIPTION} | mail -s "${EMAIL_SUBJECT}" "${EMAIL_TO_LIST}"
		fi
	fi
done < ${CLEAR2WORK_JOB_STATUS_RESULTS_FILE}

echo "clea2work_process_data.bash execution ended : $(date +"%Y%m%d_%H%M%S_%3N")"
