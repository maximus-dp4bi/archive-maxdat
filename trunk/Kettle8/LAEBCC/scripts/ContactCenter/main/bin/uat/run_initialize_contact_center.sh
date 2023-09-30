#!/bin/bash
. /u01/maximus/maxdat-uat/LAEBCC8/scripts/ContactCenter/implementation/LAEB/bin/.set_env
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/ContactCenter/trunk/kettle/MAXDAT/main/bin/run_initialize_contact_center.sh $
# $Revision: 11013 $
# $Date: 2015-10-28 10:03:52 -0700 (Wed, 28 Oct 2015) $
# $Author: lg74078 $
PROGNAME=$(basename $0 .sh)
function error_exit
{

#       ----------------------------------------------------------------
#       Function for exit due to fatal program error
#               Accepts 1 argument:
#                       string containing descriptive error message
#       ----------------------------------------------------------------


        echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
        rm -f $INIT_OK
        exit 1
}

BASEDIR=$(dirname $0)
echo $BASEDIR

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/main/jobs/initialization
JOB=initialize_Contact_Center
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo $LOG_DIR
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" $PARAMS -level="$DETAIL_LOG_LEVEL" >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
