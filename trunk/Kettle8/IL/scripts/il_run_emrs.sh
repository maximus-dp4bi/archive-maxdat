#!/bin/bash
. /u01/maximus/maxdat/IL8/config/.set_env

# il_run_emrs.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$
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


EMRSDATADIR=$MAXDAT_ETL_PATH/EnrollmentDataEMRS
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

#INIT_OK="$MAXDAT_ETL_PATH/il_emrs_init_check.txt"
CHILD_FAIL="/tmp/il_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/il_run_emrs-ERROR-LOG.txt"
EMAIL_SUBJECT="$ENV_CODE STCODE Errors With il_run_emrs.sh"

#checking for run file
#if [[ -e $INIT_OK ]] ; then
#   echo "Run Aborted - $INIT_OK exists"
#   exit;
#else
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
#   touch $INIT_OK
#fi

#init check
#Checking for database connection before continuing
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_INIT/emrs_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/$MODULE_INIT/${STCODE}_emrs_Init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?

if [[ $rc != 0 ]] ; then
     echo "$ENV_CODE $STCODE exited with status: $rc - emrs_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
#     rm -f $INIT_OK
     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
     cat $EMAIL_MESSAGE
     exit $rc
else
     $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/$MODULE_EMRS/ETL_Enrollment.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/$MODULE_EMRS/${STCODE}_EMRS_Enrollment_$(date +%Y%m%d_%H%M%S).log
     $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/$MODULE_EMRS/IL_Supplemental_Data.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/$MODULE_EMRS/${STCODE}_IL_Supplemental_Data$(date +%Y%m%d_%H%M%S).log

     rc=$?
     if [[ $rc != 0 ]] ; then

	     echo "$ENV_CODE $STCODE ETL_Enrollment.kjb failed, review error log for additional detail." >> $EMAIL_MESSAGE
	     #rm -f $INIT_OK
	     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	     cat $EMAIL_MESSAGE
	     error_exit "$LINENO: An error has occurred in ILEB_run_emrs.sh"
     fi
fi
#rm -f $INIT_OK

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
