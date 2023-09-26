# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
#   SVN_FILE_URL := '$URL$'; 
#   SVN_REVISION := '$Revision$'; 
#   SVN_REVISION_DATE := '$Date$'; 
#   SVN_REVISION_AUTHOR := '$Author$';
# ================================================================================

. /u01/maximus/maxdat-uat/CiscoEnterprise8/ETL/scripts/ContactCenter/implementation/CiscoEnterprise/bin/.set_env

BASEDIR=$(dirname $0)
echo $BASEDIR

#. $MAXDAT_ETL_PATH/CiscoEnterprise/ETL/scripts/ContactCenter/implementation/CiscoEnterprise/bin/set_env_vars.sh


# This program will run the Kettle job necessary to export AMP metrics a scheduled basis (weekly and monthly)

PROGNAME=$(basename $0)
REPORTINGPERIODTYPE=$1

echo "Start of program:  $PROGNAME"
echo "Report type:  $REPORTINGPERIODTYPE"

# function to display the Kitchen return code
kitchen_status()
{
# kitchen status codes
kitchenStatusDefs[1]="Errors occurred during processing"
kitchenStatusDefs[2]="An unexpected error occurred during loading or running of the job"
kitchenStatusDefs[7]="The job couldn't be loaded from XML or the Repository"
kitchenStatusDefs[8]="Error loading steps or plugins (error in loading one of the plugins mostly)"
kitchenStatusDefs[9]="Command line usage printing"
kitchenStatusDefs[0]="Success"
echo "PDI reports the following error:  $1 - " ${kitchenStatusDefs[$1]}
}

# function for exit due to fatal program error
function error_exit
{
#       ----------------------------------------------------------------
#               Accepts 1 argument:
#                       string containing descriptive error message
#       ----------------------------------------------------------------

        echo "see LOG FILE for details."
        echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
        exit 1
}


if [[ $# -ne 1 ]]
then
	echo "ERROR - A report type is required, e.g.:  sh run_load_contact_center_metrics.sh \"WEEKLY\""
else
	JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs/amp
	JOB=execute_scheduled_calculate_amp_metrics
	echo "ETL directory:  $MAXDAT_ETL_PATH"
	echo "Job directory:  $JOBS_DIR"

# email-related variables
STCODE=${STCODE^}
ENV_CODE=${ENV_CODE^^}
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="$JOBS_DIR/$(basename $0)_ERROR_LOG"
EMAIL_SUBJECT="$STCODE $ENV_CODE - Errors with $STCODE_$(basename $0)"

# log variables
LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo "Log directory:  $LOG_DIR"
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL" -param:reportingPeriodType="$REPORTINGPERIODTYPE" >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
rc=$?
	# email on failure
	if [[ $rc != 0 ]] ; then
		echo "Exited with status: $rc - $(basename $0), aborting run in $STCODE $ENV_CODE"  > $EMAIL_MESSAGE
		mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
		cat $EMAIL_MESSAGE
		exit $rc
        fi

fi

#kitchen status code
# 0 The job ran without a problem.
# 1 Errors occurred during processing
# 2 An unexpected error occurred during loading or running the job
# 7 The job couldn't be loaded from XML or the Repository
# 8 Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 Command line usage printing
