#!/bin/bash
#
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
#   SVN_FILE_URL varchar2(200) := '$URL$'; 
#   SVN_REVISION varchar2(20) := '$Revision$'; 
#   SVN_REVISION_DATE varchar2(60) := '$Date$'; 
#   SVN_REVISION_AUTHOR varchar2(20) := '$Author$';
#
#
#Input Parameters
JOB_ID=${1}
JOB_COMMAND=${2}
JOB_LOG_FILE=${3}

#results file names
JOB_RUN_FILE_SUFFIX=$(date +"%Y%m%d_%H%M%S_%3N")
ADD_JOB_RESULTS_FILE=${ETL_JOBCONTROL_DATA_PATH}/add_etl_job_results_${JOB_RUN_FILE_SUFFIX}.dat
COMPLETE_JOB_RESULTS_FILE=${ETL_JOBCONTROL_DATA_PATH}/complete_etl_job_results_${JOB_RUN_FILE_SUFFIX}.dat

#debug message
echo "etl_job_exec.bash: executing JOB ID: ${JOB_ID}, COMMAND: ${JOB_COMMAND}, JOB LOG: ${JOB_LOG_FILE}"

# Create a new instance of the job before executing the job
${DB_MAXDAT_CLIENT} -S ${DB_MAXDAT_USER}/${DB_MAXDAT_PASSWORD}@//${DB_MAXDAT_HOSTNAME}:${DB_MAXDAT_PORT}/${DB_MAXDAT_NAME} @${ETL_JOBCONTROL_SQL_PATH}/add_etl_job.sql "${JOB_ID}" > ${ADD_JOB_RESULTS_FILE}

if [ -s ${ADD_JOB_RESULTS_FILE} ]; then
	echo "Error - SQL failed in creating a new job run instance for Job ID: ${JOB_ID} and script will not be executed. Refer the error details in ${ADD_JOB_RESULTS_FILE} file"
	exit
else
	echo "successfully added a new run instance for Job ID: ${JOB_ID} and set to STARTED status"
fi

# Execute the Job Command
bash ${JOB_COMMAND} >> ${JOB_LOG_FILE}

# Set the job instance status to COMPLETE
${DB_MAXDAT_CLIENT} -S ${DB_MAXDAT_USER}/${DB_MAXDAT_PASSWORD}@//${DB_MAXDAT_HOSTNAME}:${DB_MAXDAT_PORT}/${DB_MAXDAT_NAME} @${ETL_JOBCONTROL_SQL_PATH}/complete_etl_job.sql "${JOB_ID}" > ${COMPLETE_JOB_RESULTS_FILE}

if [ -s ${COMPLETE_JOB_RESULTS_FILE} ]; then
	echo "Error - SQL failed in updating the job run status as COMPLETED for Job# ${JOB_ID}. Refer the error details in ${COMPLETE_JOB_RESULTS_FILE} file"
    echo "Job status should be set to COMPLETE manually, by executing DB Package Procedure : ETL_JOB.COMPLETE_ETL_JOB(${JOB_ID})"
else
	echo "successfully updated the run instance status to COMPLETED for Job ID: ${JOB_ID}"
fi
