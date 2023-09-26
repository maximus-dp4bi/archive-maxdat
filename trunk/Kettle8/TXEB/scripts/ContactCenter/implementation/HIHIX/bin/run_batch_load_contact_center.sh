#!/bin/bash
. ~/.bash_profile

. $MAXDAT_ETL_PATH/set_maxdat_env_variables.sh

# tx_run_cc.sh
# This program will run the Kettle job necessary to initialize the Contact Center data mart

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

START_DATE=$1
END_DATE=$2

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/implementation/HIHIX/jobs
JOB=load_Contact_Center

PARAMS="-param:startDateParam=$START_DATE -param:endDateParam=$END_DATE"
echo $PARAMS

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="ClayRowland@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo $LOG_DIR
LOG_LEVEL="Detailed"

$SCRIPTS_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" $PARAMS -Log="$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log" -level="$LOG_LEVEL"
