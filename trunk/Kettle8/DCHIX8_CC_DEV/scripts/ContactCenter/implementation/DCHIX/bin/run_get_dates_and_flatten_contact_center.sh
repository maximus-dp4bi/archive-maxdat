#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR

#. $BASEDIR/set_env_vars.sh
. /u01/maximus/maxdat-dev/DCHIX8/scripts/ContactCenter/implementation/DCHIX8/bin/.set_env

# run_flatten_contact_center.sh
# This program will run the Kettle job to flatten the Contact Center data mart to .csv files

if [ "$(ls -A $MAXDAT_MOTS_FILES/Inbound/mots_export_dates.csv)" ]; then

	echo "Found mots_export_dates.csv"
	
	JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs/dimensional
	JOB=get_dates_and_flatten_project_facts
	echo $MAXDAT_ETL_PATH
	echo $JOBS_DIR

	BASIC_LOG_LEVEL="Basic"
	DETAIL_LOG_LEVEL="Detailed"

	# email-related variables
	STCODE=${STCODE^}
    ENV_CODE=${ENV_CODE^^}
	EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="$JOBS_DIR/$(basename $0)_ERROR_LOG"
EMAIL_SUBJECT="$STCODE $ENV_CODE - Errors with $STCODE_$(basename $0)"

	LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
	LOG_LEVEL="Detailed"

	sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL" >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

rc=$?
if [[ $rc != 0 ]] ; then
	echo "Exited with status: $rc - $(basename $0), aborting run in $STCODE $ENV_CODE"  > $EMAIL_MESSAGE
	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	cat $EMAIL_MESSAGE
	exit $rc
fi

#kitchen status codes
# 0     The job ran without a problem.
# 1     Errors occurred during processing
# 2     An unexpected error occurred during loading or running of the job
# 7     The job couldn't be loaded from XML or the Repository
# 8     Error loading steps or plugins (error in loading one of the plugins mostly)
# 9     Command line usage printing
