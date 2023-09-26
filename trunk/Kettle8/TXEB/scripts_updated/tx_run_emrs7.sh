#!/bin/ksh
. ~/.profile
# tx_run_emrs.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
#  $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/tx_run_emrs.sh $
#  $Revision: 5152 $
#  $Date: 2013-09-06 12:35:12 -0700 (Fri, 06 Sep 2013) $
#  $Author: dd27179 $
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
	rm $INIT_OK
	exit 1
}

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_emrs_init_check.txt"
EMRS_DATA_DIR=$MAXDAT_ETL_PATH/EnrollmentDataEMRS

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_emrs-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_emrs7.sh in $ENV_CODE"

#checking for run file
if [[ -f $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   rm $INIT_OK
   exit;
else
   touch $INIT_OK
fi

#init check
#Checking for databse connection befor continuing
ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/emrs_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/${STCODE}_emrs_init_check_$(date +%Y%m%d_%H%M%S).log
#creates tx_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
     echo "exited with status: $rc - ${STCODE} emrs_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
     cat $EMAIL_MESSAGE
     rm $INIT_OK
     exit $rc
else
     $MAXDAT_ETL_PATH/run_emrs_kjb7.sh $EMRS_DATA_DIR/ETL_Enrollment.kjb ETL_Enrollment >> $MAXDAT_ETL_LOGS/ETL_Enrollment$(date +%Y%m%d_%H%M%S).log 
     rc=$?
     if [[ $rc != 0 ]] ; then
	     echo "ETL_Enrollment.kjb failed in ${STCODE}EB, review error log for additional detail." >> $EMAIL_MESSAGE
	     rm -f $INIT_OK
	     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
	     cat $EMAIL_MESSAGE
	     error_exit "$LINENO: An error has occurred in ${STCODE}_run_emrs.sh"
     fi
fi
rm $INIT_OK

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
