#!/bin/bash
#
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
#   SVN_FILE_URL varchar2(200) := '$URL$'; 
#   SVN_REVISION varchar2(20) := '$Revision$'; 
#   SVN_REVISION_DATE varchar2(60) := '$Date$'; 
#   SVN_REVISION_AUTHOR varchar2(20) := '$Author$';
#
#
function get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}
#
echo " "			
echo " "
echo "etl_job_control.bash execution started : $(date +"%Y%m%d_%H%M%S_%3N")"
SCRIPTDIR="$(get_script_dir)"
SET_ENV=$(grep "^SET_ENV_FILEPATH" $SCRIPTDIR/etl_job.properties | cut -d'=' -f2)/$(grep "^SET_ENV_FILENAME" $SCRIPTDIR/etl_job.properties | cut -d'=' -f2)

. $SET_ENV

# Convert Script Paths into an array
IFS=':'
read -a SCRIPTSPATHARR <<< "$ETL_JOBCONTROL_SCRIPTS_PATH"

# Get database access variables from properties file.
KETTLE_PROPERTIES_FILE=${KETTLE_PROPERTIES_PATH}/kettle.properties

export DB_MAXDAT_HOSTNAME=$(grep "^DB_MAXDAT_HOSTNAME" ${KETTLE_PROPERTIES_FILE} | cut -d'=' -f2)
export DB_MAXDAT_PORT=$(grep "^DB_MAXDAT_PORT" ${KETTLE_PROPERTIES_FILE} | cut -d'=' -f2)
export DB_MAXDAT_NAME=$(grep "^DB_MAXDAT_NAME" ${KETTLE_PROPERTIES_FILE} | cut -d'=' -f2)
export DB_MAXDAT_USER=$(grep "^DB_MAXDAT_USER" ${KETTLE_PROPERTIES_FILE} | cut -d'=' -f2)

# If password is encrypted, decrypt it.. If not, take it as it is 
export DB_MAXDAT_PASSWORD=$(grep "^DB_MAXDAT_PASSWORD" ${KETTLE_PROPERTIES_FILE} | cut -d'=' -f2)
if [ "${DB_MAXDAT_PASSWORD:0:9}" = "Encrypted" ]; then
	DB_MAXDAT_ENCRYPTED_PASSWORD=$(grep "^DB_MAXDAT_PASSWORD" ${KETTLE_PROPERTIES_FILE} | cut -d'=' -f2 | cut -d' ' -f2)
	export CLASSPATH=$CLASSPATH:$SCRIPTDIR;
	export DB_MAXDAT_PASSWORD="$(bash $SCRIPTDIR/decr.sh $DB_MAXDAT_ENCRYPTED_PASSWORD)"
fi

# resuts file name
JOB_RUN_FILE_SUFFIX=$(date +"%Y%m%d_%H%M%S_%3N")
JOB_CONFIG_RESULTS_FILE=${ETL_JOBCONTROL_DATA_PATH}/set_etl_jobs_results_${JOB_RUN_FILE_SUFFIX}.dat

# Identify the jobs to be executed
${DB_MAXDAT_CLIENT} -S ${DB_MAXDAT_USER}/${DB_MAXDAT_PASSWORD}@//${DB_MAXDAT_HOSTNAME}:${DB_MAXDAT_PORT}/${DB_MAXDAT_NAME} @${ETL_JOBCONTROL_SQL_PATH}/set_etl_jobs.sql > ${JOB_CONFIG_RESULTS_FILE}

if [ -s ${JOB_CONFIG_RESULTS_FILE} ]; then
	echo " "			
	echo "Error - SQL failed in identifying the jobs to run and process is aborting. Refer the error details in ${JOB_CONFIG_RESULTS_FILE} file"
	echo "etl_job_control.bash execution ended : $(date +"%Y%m%d_%H%M%S_%3N")"
	exit
fi

echo "set_etl_jobs.sql execution is successful"

JOB_CONFIG_RESULTS_FILE=${ETL_JOBCONTROL_DATA_PATH}/get_etl_jobs_results_${JOB_RUN_FILE_SUFFIX}.dat
DB_COLUMN_SEPARATOR=';'
SCRIPT_FOUND='N'

# Get job config from database and execute them
${DB_MAXDAT_CLIENT} -S ${DB_MAXDAT_USER}/${DB_MAXDAT_PASSWORD}@//${DB_MAXDAT_HOSTNAME}:${DB_MAXDAT_PORT}/${DB_MAXDAT_NAME} @${ETL_JOBCONTROL_SQL_PATH}/get_etl_jobs.sql > ${JOB_CONFIG_RESULTS_FILE}

if [ ! -s "${JOB_CONFIG_RESULTS_FILE}" ]; then
	echo "Warning - NO JOBs were found to run. Check Database for configuration Issues if any job is expeceted to run at this time"
else
	echo "get_etl_jobs.sql execution is successful"    

	JOB_COUNT=0
	JOBS_ERROR_OUT=0
    
	while read JOB_CONFIG_ROW; do
		if [ "${JOB_CONFIG_ROW}" != "" ]; then
			JOB_ID=$(echo ${JOB_CONFIG_ROW} | cut -f1 -d${DB_COLUMN_SEPARATOR})
			PROJECT_NAME=$(echo ${JOB_CONFIG_ROW} | cut -f2 -d${DB_COLUMN_SEPARATOR})
			JOB_NAME=$(echo ${JOB_CONFIG_ROW} | cut -f3 -d${DB_COLUMN_SEPARATOR})
			JOB_TYPE=$(echo ${JOB_CONFIG_ROW} | cut -f4 -d${DB_COLUMN_SEPARATOR})
			PARENT_JOB_ID=$(echo ${JOB_CONFIG_ROW} | cut -f5 -d${DB_COLUMN_SEPARATOR})
			JOB_SCRIPT_NAME=$(echo ${JOB_CONFIG_ROW} | cut -f6 -d${DB_COLUMN_SEPARATOR})
            JOB_LOG_PATH=$(echo ${JOB_CONFIG_ROW} | cut -f7 -d${DB_COLUMN_SEPARATOR})
			JOB_NEXT_EXEC_DT=$(echo ${JOB_CONFIG_ROW} | cut -f8 -d${DB_COLUMN_SEPARATOR})
			
            # Default setting for each job
            JOB_COUNT=$(($JOB_COUNT+1))
            SCRIPT_FOUND="N"
            JOB_ERROR_FLAG="N"  
            JOB_ERROR_DESC="Script - ${JOB_SCRIPT_NAME} is missing in all the script folders. Unable to execute the script" 
			echo " "
			echo "JOB ID - " ${JOB_ID} ", JOB Script Name: " ${JOB_SCRIPT_NAME}
			
            # Validation #1 - check if the script has .sh extension
            if [ ${JOB_SCRIPT_NAME:${#JOB_SCRIPT_NAME}-3} != ".sh" ]; then
                JOB_ERROR_FLAG="Y"
                JOB_ERROR_DESC="Script file - ${JOB_SCRIPT_NAME} is not a valid shell script with no sh extension"    
                
            # Validation #2 - check if the log path exists
            elif [ ! -e "${JOB_LOG_PATH}" ]; then
                JOB_ERROR_FLAG="Y"
                JOB_ERROR_DESC="Log Path - ${JOB_LOG_PATH} does not exists"                
            
            # Validation #3 - check if the log path is a directory
            elif [ ! -d "${JOB_LOG_PATH}" ]; then
                JOB_ERROR_FLAG="Y"
                JOB_ERROR_DESC="Log Path - ${JOB_LOG_PATH} is not a directory"                
            
            # Validation #4 - check if the log path is writable
            elif [ ! -w "${JOB_LOG_PATH}" ]; then
                JOB_ERROR_FLAG="Y"
                JOB_ERROR_DESC="Log Path - ${JOB_LOG_PATH} is not writable"                
                    
			else
                # Check the correct path for the script and execute once it finds it 
                for SCRIPTPATH in "${SCRIPTSPATHARR[@]}";
                do
                    JOB_SCRIPT_WITH_PATH=$SCRIPTPATH/$JOB_SCRIPT_NAME
    
                    # Validation #5 - check if the script exists in the script folder and regular file
                    if [ -f "$JOB_SCRIPT_WITH_PATH" ]; then
                        
                        SCRIPT_FOUND="Y"
                        
                        # Validation #6 - check if the script file is NOT EMPTY
                        if [ ! -s "${JOB_SCRIPT_WITH_PATH}" ]; then
                            JOB_ERROR_FLAG="Y"
                            JOB_ERROR_DESC="Script file - ${JOB_SCRIPT_WITH_PATH} is empty"                
                        
                        # Validation #7 - check if the script file is READABLE
                        elif [ ! -r "${JOB_SCRIPT_WITH_PATH}" ]; then
                            JOB_ERROR_FLAG="Y"
                            JOB_ERROR_DESC="Script file - ${JOB_SCRIPT_WITH_PATH} is not readable"                
                        
                        # Validation #8 - check if the script file is EXECUTABLE
                        elif [ ! -x "${JOB_SCRIPT_WITH_PATH}" ]; then
                            JOB_ERROR_FLAG="Y"
                            JOB_ERROR_DESC="Script file - ${JOB_SCRIPT_WITH_PATH} is not executable"                

                        # Execute the script since all the validations are complete                        
                        else
                            
							# Derive JOB_COMMAND and JOB_LOG_FILE
                            JOB_COMMAND="$JOB_SCRIPT_WITH_PATH 2>&1 | sed 's/^/$(date) /'"
							JOB_LOG_FILE="${JOB_LOG_PATH}/${JOB_SCRIPT_NAME:0:${#JOB_SCRIPT_NAME}-3}_${JOB_RUN_FILE_SUFFIX}.log"
                            
                            echo "Script - ${JOB_SCRIPT_NAME} for JOB - ${JOB_ID} is found in $SCRIPTPATH folder and executing.."
                            
                            # execute etl_job_exec.bash for each job in background mode 
                            ${SCRIPTDIR}/etl_job_exec.bash "${JOB_ID}" "${JOB_COMMAND}" "${JOB_LOG_FILE}" &                            
                        fi
                        
                        # come out of the for loop as the current job script is already found in the current folder
                        break
                        
                    else
                        echo "Script - ${JOB_SCRIPT_NAME} for JOB - ${JOB_ID} is not found in $SCRIPTPATH folder"
                    fi
                done
            fi
            
			# If Job Script is missing all the script folders, log error for the job 
			if [ "$SCRIPT_FOUND" = "N" ] || [ "$JOB_ERROR_FLAG" = "Y" ]; then
				JOBS_ERROR_OUT=$(($JOBS_ERROR_OUT+1))
				JOB_CONFIG_RESULTS_FILE=${ETL_JOBCONTROL_DATA_PATH}/add_etl_log_results_${JOB_RUN_FILE_SUFFIX}.dat
				
				${DB_MAXDAT_CLIENT} -S ${DB_MAXDAT_USER}/${DB_MAXDAT_PASSWORD}@//${DB_MAXDAT_HOSTNAME}:${DB_MAXDAT_PORT}/${DB_MAXDAT_NAME} @${ETL_JOBCONTROL_SQL_PATH}/add_etl_log.sql "'${JOB_ERROR_DESC}. Unable to execute the script'" "'ERROR'" "${JOB_ID}"  > ${JOB_CONFIG_RESULTS_FILE}

				echo "Error: $JOB_ERROR_DESC for JOB - ${JOB_ID}. Unable to execute the script" 
			fi
		fi
	done < ${JOB_CONFIG_RESULTS_FILE}
	
	echo " "
	echo "Summary: Total Jobs identified for execution - ${JOB_COUNT}, Total Jobs error out - ${JOBS_ERROR_OUT}"
fi

# Get the stuck job from database and report them in the log file
JOB_CONFIG_RESULTS_FILE=${ETL_JOBCONTROL_DATA_PATH}/get_etl_stuck_jobs_results_${JOB_RUN_FILE_SUFFIX}.dat

${DB_MAXDAT_CLIENT} -S ${DB_MAXDAT_USER}/${DB_MAXDAT_PASSWORD}@//${DB_MAXDAT_HOSTNAME}:${DB_MAXDAT_PORT}/${DB_MAXDAT_NAME} @${ETL_JOBCONTROL_SQL_PATH}/get_etl_stuck_jobs.sql > ${JOB_CONFIG_RESULTS_FILE}
JOB_COUNT=0
	
if [ ! -s ${JOB_CONFIG_RESULTS_FILE} ]; then
	echo " "			
	echo "Summary: Total Jobs found to be running long or got stuck - ${JOB_COUNT}"
else
	while read JOB_CONFIG_ROW; do
		if [ "${JOB_CONFIG_ROW}" != "" ]; then
			JOB_COUNT=$(($JOB_COUNT+1))
			JOB_ID=$(echo ${JOB_CONFIG_ROW} | cut -f1 -d${DB_COLUMN_SEPARATOR})
			PROJECT_NAME=$(echo ${JOB_CONFIG_ROW} | cut -f2 -d${DB_COLUMN_SEPARATOR})
			JOB_NAME=$(echo ${JOB_CONFIG_ROW} | cut -f3 -d${DB_COLUMN_SEPARATOR})
			JOB_TYPE=$(echo ${JOB_CONFIG_ROW} | cut -f4 -d${DB_COLUMN_SEPARATOR})
			PARENT_JOB_ID=$(echo ${JOB_CONFIG_ROW} | cut -f5 -d${DB_COLUMN_SEPARATOR})
			JOB_SCRIPT_NAME=$(echo ${JOB_CONFIG_ROW} | cut -f6 -d${DB_COLUMN_SEPARATOR})
            JOB_LOG_PATH=$(echo ${JOB_CONFIG_ROW} | cut -f7 -d${DB_COLUMN_SEPARATOR})
			JOB_NEXT_EXEC_DT=$(echo ${JOB_CONFIG_ROW} | cut -f8 -d${DB_COLUMN_SEPARATOR})
			
			echo "JOB: " $JOB_ID ", SCRIPT NAME: " $JOB_SCRIPT_NAME

			echo "Warning: Job is running long or stuck. Reset the job, if necessary, after investigating the logs by executing ETL_JOB.RESET_ETL_JOB procedure for job # ${JOB_ID}" 
			
		fi
	done < ${JOB_CONFIG_RESULTS_FILE}
	
	echo " "			
	echo "Summary: Total Jobs found to be running long or got stuck - ${JOB_COUNT}"
fi 
echo " "			
echo "etl_job_control.bash execution ended : $(date +"%Y%m%d_%H%M%S_%3N")"
	