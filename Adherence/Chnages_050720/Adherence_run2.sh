#!/bin/bash
. /u01/maximus/maxdat/Adherence/config/.set_env

# il_run_emrs.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/IL/scripts/il_run_emrs.sh $
# $Revision: 28556 $
# $Date: 2019-12-19 09:59:41 -0800 (Thu, 19 Dec 2019) $
# $Author: gt83345 $
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


#EMRSDATADIR=$MAXDAT_ETL_PATH/EnrollmentDataEMRS
#BASIC_LOG_LEVEL="Basic"
#DETAIL_LOG_LEVEL="Detailed"

INIT_OK="$MAXDAT_ETL_PATH/Adherence_init_check.txt"
CHILD_FAIL="/tmp/Adherence_child_task_fail.txt"

#mail related variables
EMAIL="DouglasUmana@maximus.com"
EMAIL_MESSAGE="/tmp/Adherence_run_ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With Data Science Adherence_run.sh in $ENV_CODE"

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
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_ADH/Adherence_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/${STCODE}_Adherence_Init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?

if [[ $rc != 0 ]] ; then
     echo "exited with status: $rc - Adherence_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
     rm -f $INIT_OK
     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
     cat $EMAIL_MESSAGE
     exit $rc
else
     $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/$MODULE_ADH/Adherence_Manual_Job.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/${STCODE}_Adherence_Enrollment_$(date +%Y%m%d_%H%M%S).log
#     $MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/$MODULE_ADH/IL_Supplemental_Data.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/$MODULE_EMRS/${STCODE}_IL_Supplemental_Data$(date +%Y%m%d_%H%M%S).log

     rc=$?
     if [[ $rc != 0 ]] ; then

	     echo "Adherence_Manual_run.kjb failed in ADH, review error log for additional detail." >> $EMAIL_MESSAGE
	     rm -f $INIT_OK
	     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	     cat $EMAIL_MESSAGE
	     error_exit "$LINENO: An error has occurred in Adherence_run2.sh"
		 else
		 EMAIL_MESSAGE="Successful run With Data Science Adherence_run.sh in $ENV_CODE"
		 EMAIL_SUBJECT="Data Science Adherence Job Completed Successfuly"
		 echo "Adherence_Manual_run.kjb succesful." >> $EMAIL_MESSAGE
	     rm -f $INIT_OK
	     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	     cat $EMAIL_MESSAGE
	     
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
