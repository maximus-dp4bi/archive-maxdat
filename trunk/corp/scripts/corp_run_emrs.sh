#!/bin/bash
source $MD_SETENV
# corp_run_emrs.sh
# ===============================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
#  $URL$
#  $Revision$
#  $Date$
#  $Author$
# ===============================================================================
#  This is the corporate shell to run EMRS.  It has been changed to enable it to
#    run concurrent with BPM if needed.
# ===============================================================================
#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------
PROGNAME=$(basename $0 .sh)
function error_exit
{
	echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
	rm $EINIT_OK
	exit 1
}
#
#checking for EMRS run file
if [[ -f $EINIT_OK ]] ; then
   echo "Run Aborted - $EINIT_OK exists"
   exit;
else
   touch $EINIT_OK
fi
#
# Checking for databse connection befor continuing
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/emrs_Init_check.kjb" -level="$KJB_LOG_LEVEL" > $MAXDAT_ETL_LOGS/${STCODE}_emrs_init_check_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
   EMAIL_SUBJECT="Errors With ${STCODE}_run_emrs.sh in $ENV_CODE"
   echo "exited with status: $rc - ${STCODE} emrs_Init_check.kjb, aborting run in $ENV_CODE" >> $EMAIL_MESSAGE
   mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
   cat $EMAIL_MESSAGE
   rm $EINIT_OK
   exit $rc
else
   $MAXDAT_ETL_PATH/run_kjb.sh $EMRS_DATA_DIR/ETL_Enrollment.kjb $KJB_LOG_LEVEL > $MAXDAT_ETL_LOGS/EMRS_Enrollment$(date +%Y%m%d_%H%M%S).log 
   rc=$?
   if [[ $rc != 0 ]] ; then
      echo "ETL_Enrollment.kjb failed in ${STCODE}EB, review error log for additional detail." >> $EMAIL_MESSAGE
      rm -f $EINIT_OK
      mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
      cat $EMAIL_MESSAGE
      error_exit "$LINENO: An error has occurred with ${STCODE}_run_emrs.sh in ${ENV_CODE}"
   fi
fi

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
