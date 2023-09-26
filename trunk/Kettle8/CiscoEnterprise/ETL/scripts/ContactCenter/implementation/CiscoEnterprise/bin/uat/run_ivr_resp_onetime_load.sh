# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
#   SVN_FILE_URL := '$URL$'; 
#   SVN_REVISION := '$Revision$'; 
#   SVN_REVISION_DATE := '$Date$'; 
#   SVN_REVISION_AUTHOR := '$Author$';
# ================================================================================

#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR

#. $BASEDIR/set_env_vars.sh
#. /u01/maximus/maxdat-dev/CALL8/scripts/main/bin/.set_env
. $BASEDIR/.set_env

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/implementation/CiscoEnterprise/jobs/IVR_OneTime_Load
JOB=process_CC_S_IVR_RESPONSE_uat
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

CONFIG_ENV_CODE=$ENV_CODE

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
STCODE=${STCODE^}
ENV_CODE=${ENV_CODE^^}
EMAIL="151500@maximus.com"
EMAIL_MESSAGE="$JOBS_DIR/$(basename $0)_ERROR_LOG"
EMAIL_SUBJECT="$STCODE $ENV_CODE - Errors with $STCODE_$(basename $0)"
INBOUND_DIR=/u01/maximus/maxdat-$CONFIG_ENV_CODE/CiscoEnterprise8/PSI/Inbound/IVR_OneTime_Load
LOG_DIR=$MAXDAT_ETL_LOGS/IVR_OneTime_Load
echo $LOG_DIR
LOG_LEVEL="Detailed"

# sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
# rc=$?
# if [[ $rc != 0 ]] ; then
#	echo "Exited with status: $rc - $(basename $0), aborting run in $STCODE $ENV_CODE"  > $EMAIL_MESSAGE
#	mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
#	cat $EMAIL_MESSAGE
#	exit $rc
# fi

responsefilecount=$(find $INBOUND_DIR/ -maxdepth 1 -type f -name '*_RESPONSE_*.csv' | wc -l)

counter=1

while [  $counter -le $responsefilecount ]
do
   echo $counter
   sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
   rc=$?
   let counter=counter+1
done
