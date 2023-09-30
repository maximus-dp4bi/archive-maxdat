#!/bin/bash
. ~/.bash_profile
# il_run_emrs.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/IL/ETL/scripts/il_run_emrs.sh $
# $Revision: 5016 $
# $Date: 2013-09-04 10:04:52 -0700 (Wed, 04 Sep 2013) $
# $Author: aa24065 $
# calls the daily load script for kettel
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-\"Unknown Error\"}" 1>&2
	exit 1
}
export STCODE=IL
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/ETL/logs
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/$STCODE/ETL/scripts
PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME

KETTLEDIR="/u01/app/appadmin/product/pentaho/data-integration"
EMRSSCRIPTS=$MAXDAT_ETL_PATH
EMRSDATADIR=$EMRSSCRIPTS/EnrollmentDataEMRS
LOG_DIR=$MAXDAT_ETL_LOGS
ERR_DIR=$MAXDAT_ETL_PATH/../error
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

INIT_OK="$EMRSSCRIPTS/il_emrs_init_check.txt"
CHILD_FAIL="/tmp/il_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/il_run_emrs-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With il_run_emrs.sh"

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
$KETTLEDIR/kitchen.sh -file="$EMRSSCRIPTS/emrs_Init_check.kjb" -level="$DETAIL_LOG_LEVEL"  >> $LOG_DIR/il_emrs_Init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?

if [[ $rc != 0 ]] ; then
     echo "exited with status: $rc - IL emrs_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
     rm -f $INIT_OK
     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
     cat $EMAIL_MESSAGE
     exit $rc
else
     $EMRSSCRIPTS/run_emrs_kjb.sh $EMRSDATADIR/ETL_Load_MISSING_PROVIDERS_ADHOC.kjb  ETL_Load_MISSING_PROVIDERS_ADHOC >> $LOG_DIR/ETL_Load_MISSING_PROVIDERS_ADHOC_$(date +%Y%m%d_%H%M%S).log &    
     rc=$?
     if [[ $rc != 0 ]] ; then

	     echo "EMRS_Load_Providers_Notif_adhoc failed in ILEB, review error log for additional detail." >> $EMAIL_MESSAGE
	     rm -f $INIT_OK
	     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	     cat $EMAIL_MESSAGE
	     error_exit "$LINENO: An error has occurred in ILEB_run_emrs.sh"
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
