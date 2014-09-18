#!/bin/ksh
. ~/.profile
# tx_emrs_init_load.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$
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

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
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
   $MAXDAT_ETL_PATH/run_emrs_ktr.sh $EMRS_DATA_DIR/EMRS_set_etl_run_date.ktr EMRS_set_etl_run_date >> $MAXDAT_ETL_LOGS/EMRS_set_etl_run_date_$(date +%Y%m%d_%H%M%S).log
   rc=$?
   if [[ $rc == 0 ]] ; then
   $MAXDAT_ETL_PATH/run_emrs_kjb.sh $EMRS_DATA_DIR/ETL_Load_Dimension_Lookups.kjb ETL_Load_Dimension_Lookups >> $MAXDAT_ETL_LOGS/EMRS_Load_Dimension_Lookups_$(date +%Y%m%d_%H%M%S).log
  rc=$?
   if [[ $rc == 0 ]] ; then
      $EMRSSRIPTS/run_emrs_kjb.sh $EMRSDATADIR/ETL_Load_AA_Dimensions_ONETIMERUN.kjb ETL_Load_AA_Dimensions_ONETIMERUN >> $MAXDAT_ETL_LOGS/EMRS_Load_AA_Dimensions_ONETIMERUN_$(date +%Y%m%d_%H%M%S).log
   rc=$?
   if [[ $rc == 0 ]] ; then
      $MAXDAT_ETL_PATH/run_emrs_kjb.sh $EMRS_DATA_DIR/ETL_Load_PROVIDERS_HIST_ONETIMERUN.kjb ETL_Load_PROVIDERS_HIST_ONETIMERUN >> $MAXDAT_ETL_LOGS/EMRS_Load_PROVIDERS_HIST_ONETIMERUN_$(date +%Y%m%d_%H%M%S).log
      rc=$?
      if [[ $rc == 0 ]] ; then
         $MAXDAT_ETL_PATH/run_emrs_kjb.sh $EMRS_DATA_DIR/ETL_Load_Cases_HIST_ONETIMERUN.kjb ETL_Load_Cases_HIST_ONETIMERUN >> $MAXDAT_ETL_LOGS/EMRS_Load_Cases_HIST_ONETIMERUN_$(date +%Y%m%d_%H%M%S).log
         rc=$?
         if [[ $rc == 0 ]] ; then
            $MAXDAT_ETL_PATH/run_emrs_kjb.sh $EMRS_DATA_DIR/ETL_Load_Clients_HIST_ONETIMERUN.kjb ETL_Load_Clients_HIST_ONETIMERUN >> $MAXDAT_ETL_LOGS/EMRS_Load_Clients_HIST_ONETIMERUN_$(date +%Y%m%d_%H%M%S).log
            rc=$?
            if [[ $rc == 0 ]] ; then
               $MAXDAT_ETL_PATH/run_emrs_ktr.sh $EMRS_DATA_DIR/DIM_Load_NOTIFICATIONS_HIST.ktr DIM_Load_NOTIFICATIONS_HIST >> $MAXDAT_ETL_LOGS/EMRS_DIM_Load_NOTIFICATIONS_HIST_$(date +%Y%m%d_%H%M%S).log
               rc=$?
               if [[ $rc == 0 ]] ; then
                  $MAXDAT_ETL_PATH/run_emrs_kjb.sh $EMRS_DATA_DIR/ETL_Load_Enrollment_Fact_CHIP_ONETIME.kjb ETL_Load_Enrollment_Fact_CHIP_ONETIME >> $MAXDAT_ETL_LOGS/EMRS_Load_Enrollment_Fact_CHIP_ONETIME_$(date +%Y%m%d_%H%M%S).log                  
                     rc=$?
                     if [[ $rc == 0 ]] ; then
                        $MAXDAT_ETL_PATH/run_emrs_kjb.sh $EMRS_DATA_DIR/ETL_Load_Enrollment_Fact_MEDICAID_ONETIME.kjb ETL_Load_Enrollment_Fact_MEDICAID_ONETIME >> $MAXDAT_ETL_LOGS/EMRS_Load_Enrollment_Fact_MEDICAID_ONETIME_$(date +%Y%m%d_%H%M%S).log                       
                  rc=$?
                  if [[ $rc == 0 ]] ; then
                     $MAXDAT_ETL_PATH/run_emrs_ktr.sh $EMRS_DATA_DIR/DIM_Load_ENROLLMENT_NOTIFICATION.ktr DIM_Load_ENROLLMENT_NOTIFICATION >> $MAXDAT_ETL_LOGS/EMRS_DIM_Load_ENROLLMENT_NOTIFICATION_$(date +%Y%m%d_%H%M%S).log
                     rc=$?
                     if [[ $rc == 0 ]] ; then
                        $MAXDAT_ETL_PATH/run_emrs_kjb.sh $EMRS_DATA_DIR/ETL_Load_Selection_Transactions_ONETIMERUN.kjb ETL_Load_Selection_Transactions_ONETIMERUN >> $MAXDAT_ETL_LOGS/EMRS_Load_Selection_Transactions_ONETIMERUN_$(date +%Y%m%d_%H%M%S).log
                        rc=$?
                        if [[ $rc == 0 ]] ; then
                        $MAXDAT_ETL_PATH/run_emrs_ktr.sh $EMRS_DATA_DIR/DIM_Load_ADDRESS_HIST.ktr DIM_Load_ADDRESS_HIST >> $MAXDAT_ETL_LOGS/EMRS_DIM_Load_ADDRESS_HIST_$(date +%Y%m%d_%H%M%S).log
                        fi
                     fi
                  fi
               fi
            fi
         fi
       fi
      fi
     fi
    fi
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
