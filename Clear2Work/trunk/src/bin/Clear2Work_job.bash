#!/bin/bash

# Run AMP - Clear2Work job.
# Get report config from the database and run script to run and process each eligible MicroStrategy report.
# MicroStrategy report XML output will be transformed into an AMP XML File.
# The AMP XML File wll be placed into a folder so that the AMP XML File processor can load the data into the AMP database.

# Trap and write command causing error.
error_handling () {
    ERROR_CODE=$?
    echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: `basename "$0"` line ${BASH_LINENO[0]} failed to run '${BASH_COMMAND}'."
    exit $ERROR_CODE
}
	
error_handling_no_exit () {
    ERROR_CODE=$?
    echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: `basename "$0"` line ${BASH_LINENO[0]} failed to run '${BASH_COMMAND}'."
}
trap error_handling ERR

# Display commands used and preserve intermediate files.
DEBUG_FLAG=N
if [ "${DEBUG_FLAG}" = "Y" ]; then
	set -x
fi
SQL_DEBUG_SWITCH='off'
if [ "${DEBUG_FLAG}" = "Y" ]; then
	SQL_DEBUG_SWITCH='on'
fi

# Validate correct number of parameters.
if [ "$#" != "0" ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") Usage: `basename "$0"`"
	exit
fi

# Clear2Work install directory.
CLEAR2WORK_HOME=$(dirname $(dirname ${BASH_SOURCE[0]}))
if [ ! -e ${CLEAR2WORK_HOME} ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Clear2Work install directory '${CLEAR2WORK_HOME}' does not exist."
	exit
elif [ ! -d ${CLEAR2WORK_HOME} ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Clear2Work install directory '${CLEAR2WORK_HOME}' is not a directory."
	exit
elif [ ! -r ${CLEAR2WORK_HOME} ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Clear2Work install directory '${CLEAR2WORK_HOME}' is not readable."
	exit
elif [ ! -s ${CLEAR2WORK_HOME} ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Clear2Work install directory '${CLEAR2WORK_HOME}' is empty."
	exit
fi

# DEPENDENCY: AMP Automated Data Capture install directory.
AMP_ADC_HOME=${CLEAR2WORK_HOME}/../AMP_ADC
if [ ! -e ${AMP_ADC_HOME} ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Automated Data Capture install directory '${AMP_ADC_HOME}' does not exist."
	exit
elif [ ! -d ${AMP_ADC_HOME} ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Automated Data Capture install directory '${AMP_ADC_HOME}' is not a directory."
	exit
elif [ ! -r ${AMP_ADC_HOME} ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Automated Data Capture install directory '${AMP_ADC_HOME}' is not readable."
	exit
elif [ ! -s ${AMP_ADC_HOME} ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Automated Data Capture install directory '${AMP_ADC_HOME}' is empty."
	exit
fi

# Get database access variables from properties file.
DB_ACCESS_PROPERTIES_FILE=${AMP_ADC_HOME}/config/db_access.properties
if [ ! -e ${DB_ACCESS_PROPERTIES_FILE} ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Database access properties file '${DB_ACCESS_PROPERTIES_FILE}' does not exist."
	exit
elif [ ! -f ${DB_ACCESS_PROPERTIES_FILE} ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Database access properties file '${DB_ACCESS_PROPERTIES_FILE}' is not a regular file."
	exit
elif [ ! -r ${DB_ACCESS_PROPERTIES_FILE} ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Database access properties file '${DB_ACCESS_PROPERTIES_FILE}' is not readable."
	exit
elif [ ! -s ${DB_ACCESS_PROPERTIES_FILE} ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Database access properties file '${DB_ACCESS_PROPERTIES_FILE}' is empty."
	exit
fi

DB_TYPE=$(grep "^DB_TYPE" ${DB_ACCESS_PROPERTIES_FILE} | cut -d'=' -f2)
if [ "${DB_TYPE}" != "ORACLE" ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Unsupported DB_TYPE '${DB_TYPE}' in '${DB_ACCESS_PROPERTIES_FILE}' database access property file.  Only 'ORACLE' is supported."
	exit
fi

DB_HOME=$(grep "^DB_HOME" ${DB_ACCESS_PROPERTIES_FILE} | cut -d'=' -f2)
if [ -z "${DB_HOME}" ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Property DB_HOME is empty in '${DB_ACCESS_PROPERTIES_FILE}' database access property file. "
	exit
fi
export ORACLE_HOME=${DB_HOME}

DB_LD_LIBRARY_PATH=$(grep "^DB_LD_LIBRARY_PATH" ${DB_ACCESS_PROPERTIES_FILE} | cut -d'=' -f2)
if [ -z "${DB_LD_LIBRARY_PATH}" ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Property DB_LD_LIBRARY_PATH is empty in '${DB_ACCESS_PROPERTIES_FILE}' database access property file. "
	exit
fi
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${DB_LD_LIBRARY_PATH}

DB_CLIENT=$(grep "^DB_CLIENT" ${DB_ACCESS_PROPERTIES_FILE} | cut -d'=' -f2)
if [ -z "${DB_CLIENT}" ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Property DB_CLIENT is empty in '${DB_ACCESS_PROPERTIES_FILE}' database access property file. "
	exit
fi

DB_LOADER=`dirname ${DB_CLIENT}`/sqlldr

DB_HOST=$(grep "^DB_HOST" ${DB_ACCESS_PROPERTIES_FILE} | cut -d'=' -f2)
if [ -z "${DB_HOST}" ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Property DB_HOST is empty in '${DB_ACCESS_PROPERTIES_FILE}' database access property file. "
	exit
fi

DB_PORT=$(grep "^DB_PORT" ${DB_ACCESS_PROPERTIES_FILE} | cut -d'=' -f2)
if [ -z "${DB_PORT}" ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Property DB_PORT is empty in '${DB_ACCESS_PROPERTIES_FILE}' database access property file. "
	exit
fi

DB_SERVICE=$(grep "^DB_SERVICE" ${DB_ACCESS_PROPERTIES_FILE} | cut -d'=' -f2)
if [ -z "${DB_SERVICE}" ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Property DB_SERVICE is empty in '${DB_ACCESS_PROPERTIES_FILE}' database access property file. "
	exit
fi

DB_USERNAME=$(grep "^DB_USERNAME" ${DB_ACCESS_PROPERTIES_FILE} | cut -d'=' -f2)
if [ -z "${DB_USERNAME}" ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Property DB_USERNAME is empty in '${DB_ACCESS_PROPERTIES_FILE}' database access property file. "
	exit
fi

# Override debug flag to hide password in debug log.
if [ "${DEBUG_FLAG}" = "Y" ]; then
	set +x
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ++ grep '^DB_PASSWORD' ${DB_ACCESS_PROPERTIES_FILE}"
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ++ cut -d= -f2"
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") + DB_PASSWORD='[REDACTED]'"
fi
DB_PASSWORD=$(grep "^DB_PASSWORD" ${DB_ACCESS_PROPERTIES_FILE} | cut -d'=' -f2)
if [ -z "${DB_PASSWORD}" ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: Property DB_PASSWORD is empty in '${DB_ACCESS_PROPERTIES_FILE}' database property file. "
	exit
fi
if [ "${DEBUG_FLAG}" = "Y" ]; then
    echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") + '[' -z '[REDACTED]' ']'"
	set -x
fi

# Get Current time in YYYY_MM_DD_HH24_MI_SS_NNN
JOB_RUN_FILE_SUFFIX=$(date +"%Y%m%d_%H%M%S_%3N")

DB_COLUMN_SEPARATOR=';'

JOB_CONFIG_RESULTS_FILE=${CLEAR2WORK_HOME}/Processing/Clear2Work_job_config_results_${JOB_RUN_FILE_SUFFIX}.dat
# Override debug flag to hide password in debug log.
if [ "${DEBUG_FLAG}" = "Y" ]; then
	set +x
	echo + ${DB_CLIENT} -S ${DB_USERNAME}/[REDACTED]@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${CLEAR2WORK_HOME}/bin/Clear2Work_get_job_config.sql > ${JOB_CONFIG_RESULTS_FILE}
fi
# Get job config from database.
${DB_CLIENT} -S ${DB_USERNAME}/${DB_PASSWORD}@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${CLEAR2WORK_HOME}/bin/Clear2Work_get_job_config.sql > ${JOB_CONFIG_RESULTS_FILE}
if [ "${DEBUG_FLAG}" = "Y" ]; then
	set -x
fi
while read JOB_CONFIG_ROW; do
	if [ "${JOB_CONFIG_ROW}" != "" ]; then
		JOB_ENABLED_FLAG=$(echo ${JOB_CONFIG_ROW} | cut -f1 -d${DB_COLUMN_SEPARATOR})
		JOB_DEBUG_FLAG=$(echo ${JOB_CONFIG_ROW} | cut -f2 -d${DB_COLUMN_SEPARATOR})
		PRESERVE_FILES_FLAG=$(echo ${JOB_CONFIG_ROW} | cut -f3 -d${DB_COLUMN_SEPARATOR})
		INPUT_FILE_DIR=$(echo ${JOB_CONFIG_ROW} | cut -f4 -d${DB_COLUMN_SEPARATOR})
	fi
done < ${JOB_CONFIG_RESULTS_FILE}
if [ "${JOB_DEBUG_FLAG}" = "Y" ]; then
	DEBUG_FLAG=Y
	SQL_DEBUG_SWITCH='on'
fi
if [ "${JOB_ENABLED_FLAG}" = "N" ]; then
	echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") INFO: Clear2Work job disabled.  To enable, set AMP_ADC_JOB_CONFIG.ENABLED_FLAG in database for this job."
	# Override debug flag to hide password in debug log.
	if [ "${DEBUG_FLAG}" = "Y" ]; then
		set +x
		echo + ${DB_CLIENT} -S ${DB_USERNAME}/[REDACTED]@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${CLEAR2WORK_HOME}/bin/Clear2Work_insert_job_run_not_enabled.sql '"'${SQL_DEBUG_SWITCH}'"' '"'${JOB_DEBUG_FLAG}'"' '"'${PRESERVE_FILES_FLAG}'"' '"'${JOB_RUN_FILE_SUFFIX}'"' '"'${USER}'"'
	fi
	# Insert job run not enabled record into database.
	${DB_CLIENT} -S ${DB_USERNAME}/${DB_PASSWORD}@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${CLEAR2WORK_HOME}/bin/Clear2Work_insert_job_run_not_enabled.sql "${SQL_DEBUG_SWITCH}" "${JOB_DEBUG_FLAG}" "${PRESERVE_FILES_FLAG}" "${JOB_RUN_FILE_SUFFIX}" "${USER}"
	if [ "${DEBUG_FLAG}" = "Y" ]; then
		set -x
	fi
	exit
fi

if [ "${INPUT_FILE_DIR}" = "INVALID_NOT_SET_YET" ] || [ ! -e ${INPUT_FILE_DIR} ] || [ ! -d ${INPUT_FILE_DIR} ] || [ ! -w ${INPUT_FILE_DIR} ]; then
	if [ ! -e ${INPUT_FILE_DIR} ]; then
		echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: AMP XML File directory '${INPUT_FILE_DIR}' does not exist."
	elif [ ! -d ${INPUT_FILE_DIR} ]; then
		echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: AMP XML File directory '${INPUT_FILE_DIR}' is not a directory."
	elif [ ! -w ${INPUT_FILE_DIR} ]; then
		echo "$(date +"%Y-%m-%d %H:%M:%S.%3N") ERROR: AMP XML File directory '${}' is not writable."
	fi
	# Override debug flag to hide password in debug log.
	if [ "${DEBUG_FLAG}" = "Y" ]; then
		set +x
		echo + ${DB_CLIENT} -S ${DB_USERNAME}/[REDACTED]@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${CLEAR2WORK_HOME}/bin/Clear2Work_insert_job_run_failed.sql '"'${SQL_DEBUG_SWITCH}'"' '"'${JOB_DEBUG_FLAG}'"' '"'${PRESERVE_FILES_FLAG}'"' '"'${JOB_RUN_FILE_SUFFIX}'"' '"'${USER}'"'
	fi
	# Insert job run failed record into database.
	${DB_CLIENT} -S ${DB_USERNAME}/${DB_PASSWORD}@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${CLEAR2WORK_HOME}/bin/Clear2Work_insert_job_run_failed.sql "${SQL_DEBUG_SWITCH}" "${JOB_DEBUG_FLAG}" "${PRESERVE_FILES_FLAG}" "${JOB_RUN_FILE_SUFFIX}" "${USER}"
	if [ "${DEBUG_FLAG}" = "Y" ]; then
		set -x
	fi
	exit
fi

JOB_RUN_ID_NEXTVAL_RESULTS_FILE=${CLEAR2WORK_HOME}/Processing/Clear2Work_job_run_id_nextval_results_${JOB_RUN_FILE_SUFFIX}.dat
# Override debug flag to hide password in debug log.
if [ "${DEBUG_FLAG}" = "Y" ]; then
	set +x
	echo + ${DB_CLIENT} -S ${DB_USERNAME}/[REDACTED]@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${CLEAR2WORK_HOME}/bin/Clear2Work_get_job_run_id_nextval.sql > ${JOB_RUN_ID_NEXTVAL_RESULTS_FILE}
fi
# Get job run ID nextval from database.
${DB_CLIENT} -S ${DB_USERNAME}/${DB_PASSWORD}@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${CLEAR2WORK_HOME}/bin/Clear2Work_get_job_run_id_nextval.sql > ${JOB_RUN_ID_NEXTVAL_RESULTS_FILE}
if [ "${DEBUG_FLAG}" = "Y" ]; then
	set -x
fi
while read JOB_RUN_ID_NEXTVAL_ROW; do
	if [ "${JOB_RUN_ID_NEXTVAL_ROW}" != "" ]; then
		JOB_RUN_ID=$(echo ${JOB_RUN_ID_NEXTVAL_ROW} | cut -f1 -d${DB_COLUMN_SEPARATOR})
	fi
done < ${JOB_RUN_ID_NEXTVAL_RESULTS_FILE}

# Override debug flag to hide password in debug log.
if [ "${DEBUG_FLAG}" = "Y" ]; then
	set +x
	echo + ${DB_CLIENT} -S ${DB_USERNAME}/[REDACTED]@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${CLEAR2WORK_HOME}/bin/Clear2Work_insert_job_run.sql '"'${SQL_DEBUG_SWITCH}'"' '"'${JOB_RUN_ID}'"' '"'${JOB_ENABLED_FLAG}'"' '"'${JOB_DEBUG_FLAG}'"' '"'${PRESERVE_FILES_FLAG}'"' '"'${JOB_RUN_FILE_SUFFIX}'"' '"'${USER}'"'
fi
# Insert job run record into database.
${DB_CLIENT} -S ${DB_USERNAME}/${DB_PASSWORD}@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${CLEAR2WORK_HOME}/bin/Clear2Work_insert_job_run.sql "${SQL_DEBUG_SWITCH}" "${JOB_RUN_ID}" "${JOB_ENABLED_FLAG}" "${JOB_DEBUG_FLAG}" "${PRESERVE_FILES_FLAG}" "${JOB_RUN_FILE_SUFFIX}" "${USER}"
if [ "${DEBUG_FLAG}" = "Y" ]; then
	set -x
fi

# Get Current time in YYYY_MM_DD_HH24_MI_SS_NNN to make unique processing run name.
PROC_FILE_SUFFIX=$(date +"%Y%m%d_%H%M%S_%3N")

# Get input files.
UPDATE_SITES_FILE_FLAG="N"
for INPUT_FILE in ${INPUT_FILE_DIR}/*.*
do
  INPUT_FILE_BASE_EXT="${INPUT_FILE##*/}"
  INPUT_FILE_BASE="${INPUT_FILE_BASE_EXT%.[^.]*}"
  INPUT_FILE_EXT="${INPUT_FILE_BASE_EXT##*.}"

  if [[ "${INPUT_FILE_BASE_EXT}" == *"_MG_Last_Day-"*.csv ]]; then
  
    # Get badge data input file and process.
    #=======================================
    echo "Badge File: " ${INPUT_FILE_BASE_EXT}
	#TODO: process file
	
  elif [[ "${INPUT_FILE_BASE_EXT}" == "COPY of Participant Questionnaire Response Daily  - "*".xlsx" ]]; then
  
    # Get Clear2Work survey data input file and process.
    #===================================================
    echo "Clear2Work Survey File: " ${INPUT_FILE_BASE_EXT}
	#TODO: process file
  fi
  
done

if [ "${UPDATE_SITES_FILE_FLAG}" == "N" ]; then
  echo "Updating Sites file, if needed."
  #TODO - Check and update Sites file from badge and Clear2Work survey data.

fi

# Cleanup after succesful job run.
#=================================
#TODO: recode this section as needed.
#if [ -e ${BADGE_PROC_FILE_ROOT}.${BADGE_FILE_EXT} ]; then
#  mv ${BADGE_PROC_FILE_ROOT}.${BADGE_FILE_EXT} ${CLEAR2WORK_HOME}/Completed
#fi

#if [ "${PRESERVE_FILES_FLAG}" = "Y" ]; then
#  mv ${CLEAR2WORK_HOME}/Processing/*_${PROC_FILE_SUFFIX}.* ${CLEAR2WORK_HOME}/Archive
#  mv ${CLEAR2WORK_HOME}/Processing/*_${PROC_FILE_SUFFIX}*.* ${CLEAR2WORK_HOME}/Archive
#else
#  rm ${CLEAR2WORK_HOME}/Processing/*_${PROC_FILE_SUFFIX}.*
#  rm ${CLEAR2WORK_HOME}/Processing/*_${PROC_FILE_SUFFIX}*.*
#fi

# Override debug flag to hide password in debug log.
if [ "${DEBUG_FLAG}" = "Y" ]; then
	set +x
	echo + ${DB_CLIENT} -S ${DB_USERNAME}/[REDACTED]@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${CLEAR2WORK_HOME}/bin/Clear2Work_complete_job_run.sql '"'${SQL_DEBUG_SWITCH}'"' '"'${JOB_RUN_ID}'"'
fi
# Complete job run record in database.
${DB_CLIENT} -S ${DB_USERNAME}/${DB_PASSWORD}@//${DB_HOST}:${DB_PORT}/${DB_SERVICE} @${CLEAR2WORK_HOME}/bin/Clear2Work_complete_job_run.sql "${SQL_DEBUG_SWITCH}" "${JOB_RUN_ID}"
if [ "${DEBUG_FLAG}" = "Y" ]; then
	set -x
fi



