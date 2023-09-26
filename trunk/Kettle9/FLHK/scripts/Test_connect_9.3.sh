PROGNAME=$(basename $0 .sh)

BASEDIR=$(dirname $0)
echo $BASEDIR

. /home/71980/setenv.sh

# This program will run the Kettle job that executes adhoc jobs

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"


JOBS_DIR=$MAXDAT_ETL_PATH
JOB=bpm_Init_check9
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="PhilipWSmith@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

LOG_DIR=$MAXDAT_ETL_LOGS
echo $LOG_DIR
LOG_LEVEL="Detailed"

sh -x /home/pentaho/design-tools/data-integration/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
