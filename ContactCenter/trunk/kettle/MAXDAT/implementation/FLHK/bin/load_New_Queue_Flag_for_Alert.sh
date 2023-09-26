#
# not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/ContactCenter/trunk/kettle/MAXDAT/main/bin/load_New_Queue_Flag_for_Alert.sh $
# $Revision: 11013 $
# $Date: 2016-12-21 14:33:13 -0400 (Wed, 21 Dec 2016) $
# $Author: lg74078 $
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	rm -f $INIT_OK
	exit 1
}

BASEDIR=$(dirname $0)
echo $BASEDIR

. $MAXDAT_ETL_PATH/scripts/ContactCenter/implementation/FLHK/bin/set_env_vars.sh

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=/home/etladmin/maxbi/ETL/scripts/ContactCenter/main/jobs/staging/Avaya
JOB=load_New_Queue_Flag_for_Alert
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="LavanyaGopal@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

LOG_DIR=$MAXDAT_LOG_DIR/ContactCenter
echo $LOG_DIR
LOG_LEVEL="Detailed"

ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" $PARAMS -level="$DETAIL_LOG_LEVEL" >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

