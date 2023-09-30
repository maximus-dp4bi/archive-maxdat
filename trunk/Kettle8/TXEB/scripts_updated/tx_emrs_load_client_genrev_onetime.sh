#!/bin/ksh
. /dtxe4t/ETL_Scripts/scripts8/.set_env
# tx_emrs_init_load.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/TX/ETL/scripts/tx_emrs_load_client_genrev_onetime.sh $
# $Revision: 7769 $
# $Date: 2014-01-17 07:58:38 -0800 (Fri, 17 Jan 2014) $
# $Author: dd27179 $
# One time intial load of EMRS
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

INIT_OK="$MAXDAT_ETL_PATH/tx_emrs_init_check.txt"
EMRS_DATA_DIR=$MAXDAT_ETL_PATH/EnrollmentDataEMRS

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/tx_run_init_load-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With tx_run_init_load.sh"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#init check
ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/emrs_Init_check.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/tx_erms_init_check_$(date +%Y%m%d_%H%M%S).log
#creates tx_run_init_check.txt
rc=$?
#rc=0 #test only - could not connect to mail server in test
if [[ $rc != 0 ]] ; then
     echo "exited with status: $rc - TX emrs_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
     cat $EMAIL_MESSAGE
     exit $rc
fi
if [[ $rc == 0 ]] ## for testing && -e $INIT_OK ]]
then
   # run the sequence of scripts dependent on each one finishing successfully
      rc=$?
       if [[ $rc == 0 ]] ; then
           $MAXDAT_ETL_PATH/run_emrs_kjb.sh $EMRS_DATA_DIR/ETL_Load_Clients_GENREV_ADHOC.kjb ETL_Load_Clients_GENREV_ADHOC >> $MAXDAT_ETL_LOGS/ETL_Load_Clients_GENREV_ADHOC_$(date +%Y%m%d_%H%M%S).log       
    fi
else
   #mail here, it didn't work, no connectivity
   echo "emrs_init_check.kjb failed in TXEB, review error log for additional detail." >> $EMAIL_MESSAGE
   mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
   cat $EMAIL_MESSAGE
   error_exit "$LINENO: An error has occurred in TXEB. tx_emrs_init_load.sh.sh"
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
