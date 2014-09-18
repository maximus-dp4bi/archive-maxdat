#!/bin/ksh
. ~/.bash_profile
# fl_run_emrs.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/IL/ETL/scripts/fl_run_emrs.sh $
# $Revision: 4962 $
# $Date: 2013-08-29 15:36:30 -0600 (Thu, 29 Aug 2013) $
# $Author: gr52181 $
# calls the daily load script for kettel
PROGNAME=$(basename $0 .sh)
function error_exit
{

#----------------------------------------------------------------
#Function for exit due to fatal program error
#Accepts 1 argument:
#string containing descriptive error message
#----------------------------------------------------------------


echo "${PROGNAME}: ${1:-\"Unknown Error\"}" 1>&2
exit 1
}
export PENTAHO_JAVA_HOME="/opt/tools/jdk1.7.0/jre/"
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/logs
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/scripts
PATH=$KETTLE_FL_HOME/.kettle/kettle.properties:.:/home/pentaho/design-tools/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_FL_HOME

KETTLEDIR="/home/pentaho/design-tools/data-integration"
EMRSSCRIPTS=$MAXDAT_ETL_PATH
EMRSDATADIR=$EMRSSCRIPTS/EMRSEnrollmentData
LOG_DIR=$MAXDAT_ETL_LOGS
ERR_DIR=$MAXDAT_ETL_PATH/../errors
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

INIT_OK="$EMRSSCRIPTS/fl_emrs_init_check.txt"
CHILD_FAIL="/tmp/fl_child_task_fail.txt"

#mail related variables
EMAIL="phsmith@Policy-Studies.com"
EMAIL_MESSAGE="/tmp/fl_run_emrs-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With fl_run_emrs.sh"

#checking for run file
if [[ -e $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   exit;
else
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_OK
fi

#init check
#Checking for database connection before continuing
$KETTLEDIR/kitchen.sh -file="$EMRSSCRIPTS/emrs_Init_check.kjb" -level="$DETAIL_LOG_LEVEL"  >> $LOG_DIR/fl_emrs_Init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?

if [[ $rc != 0 ]] ; then
     echo "exited with status: $rc - IL emrs_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
     rm -f $INIT_OK
     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
     cat $EMAIL_MESSAGE
     exit $rc
else
     $EMRSSCRIPTS/run_emrs_kjb.sh $EMRSDATADIR/ETL_Enrollment.kjb ETL_Enrollment >> $LOG_DIR/EMRS_Enrollment_$(date +%Y%m%d_%H%M%S).log
     rc=$?
     if [[ $rc != 0 ]] ; then

     echo "ETL_Enrollment.kjb failed, review error log for additional detail." >> $EMAIL_MESSAGE
     rm -f $INIT_OK
     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
     cat $EMAIL_MESSAGE
     error_exit "$LINENO: An error has occurred in fl_run_emrs.sh"
     fi
fi
rm -f $INIT_OK

#pan status codes
# 0 	The transformation ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading / running of the transformation
# 3 	Unable to prepare and initialize this transformation
# 7 	The transformation couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing

#kitchen status codes
# 0 	The job ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading or running of the job
# 7 	The job couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing
