#!/bin/bash
#. ~/.bash_profile
# IL_run_emrs7.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used  later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$
# calls the daily load script for kettel
PROGNAME=$(basename $0 .sh)
echo "Starting $PROGNAME in $ENV_CODE at $(date +%Y%m%d_%H%M%S)"
function error_exit
{

#	 ----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#		 	string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:- \"Unknown Error\"}" 1>&2
	exit 1
}

#variables moved to setenv_var7 for Pentaho 7 08/02/17
#KETTLEDIR="/u01/app/appadmin/product/pentaho/data- integration"
#EMRSSCRIPTS=$MAXDAT_ETL_PATH
EMRSDATADIR=$MAXDAT_ETL_PATH/EnrollmentDataEMRS
#LOG_DIR=$MAXDAT_ETL_LOGS
#ERR_DIR=$MAXDAT_ETL_PATH/../error
#BASIC_LOG_LEVEL="Basic"
#DETAIL_LOG_LEVEL="Detailed"

INIT_OK="${MAXDAT_ETL_PATH}/il_emrs_init_check${PDI_VERSION}.txt"
#CHILD_FAIL="/tmp/il_child_task_fail.txt"

# ---- Override  Generic email variables from setenv  -----
#EMAIL="CameronHill@maximus.com"
EMAIL_MESSAGE="/tmp/IL_run_emrs7-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With  IL_run_emrs7.sh"

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
#replaced with run_kjb7 08/02/17
#$KETTLEDIR/kitchen.sh - file="$EMRSSCRIPTS/emrs_Init_check.kjb" -level="$DETAIL_LOG_LEVEL"  >> $LOG_DIR/il_emrs_Init_check_$(date +%Y%m%d_%H%M%S).log

$MAXDAT_ETL_PATH/run_kjb7.sh  $MAXDAT_ETL_PATH/emrs_Init_check.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/${STCODE}_emrs_Init_check${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log

rc=$?

if [[ $rc != 0 ]] ; then
      echo "exited with status: $rc - IL emrs_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
     rm -f $INIT_OK
     mail -s "$EMAIL_SUBJECT" "$EMAIL" <  $EMAIL_MESSAGE
     cat $EMAIL_MESSAGE
     exit $rc
else
$MAXDAT_ETL_PATH/run_kjb7.sh $EMRSDATADIR/ETL_Enrollment.kjb $KJB_LOG_LEVEL >>  $MAXDAT_ETL_LOGS/EMRS_Enrollment${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log
$MAXDAT_ETL_PATH/run_kjb7.sh $EMRSDATADIR/IL_Supplemental_Data.kjb $KJB_LOG_LEVEL >>  $MAXDAT_ETL_LOGS/IL_Supplemental_Data${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log

#replaced with run_kjb7 08/02/17
#$EMRSSCRIPTS/run_emrs_kjb.sh  $EMRSDATADIR/ETL_Enrollment.kjb ETL_Enrollment >> $LOG_DIR/EMRS_Enrollment_$(date +%Y%m%d_%H%M%S).log
#$EMRSSCRIPTS/run_emrs_kjb.sh  
#$EMRSDATADIR/IL_Supplemental_Data.kjb IL_Supplemental_Data >> $LOG_DIR/IL_Supplemental_Data$(date +%Y%m%d_%H%M%S).log

rc=$?
if [[ $rc == 0 ]] ; then
   echo "IL_run_emrs7.sh process completed successfully at $(date +%Y%m%d_%H%M%S)."
else
   echo "IL_run_emrs7.sh process failed with error code $rc.  See log files for details."
fi
rm -f  $INIT_OK
fi
exit $rc
#pan status codes
# 0 	The transformation ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during  loading / running of the transformation
# 3 	Unable to prepare and initialize this transformation
# 7 	The transformation couldn't be loaded from  XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
# 9 	Command line usage printing

#kitchen status  codes
# 0 	The job ran without a problem.
# 1 	Errors occurred during processing
# 2 	An unexpected error occurred during loading or running of  the job
# 7 	The job couldn't be loaded from XML or the Repository
# 8 	Error loading steps or plugins (error in loading one of the plugins mostly)
#  9 	Command line usage printing
