#!/bin/ksh
. /u01/maximus/maxdat/IL8/config/.set_env

# il_emrs_init_load.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/IL/ETL/scripts/il_emrs_init_load.sh $
# $Revision: 4490 $
# $Date: 2013-08-08 10:13:39 -0700 (Thu, 08 Aug 2013) $
# $Author: aa24065 $
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
#set up the environment
EMRSDATADIR=$MAXDAT_ETL_PATH/$MODULE_EMRS

INIT_OK="$MAXDAT_ETL_PATH/il_emrs_init_check.txt"
CHILD_FAIL="/tmp/il_child_task_fail.txt"

#mail related variables
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/il_emrs_init_load-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With il_emrs_init_load.sh"

rm -f $EMAIL_MESSAGE $CHILD_FAIL

#init check
ksh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/$MODULE_INIT/emrs_Init_check.kjb" -level="$DETAIL_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/$MODULE_INIT/il_erms_init_check_$(date +%Y%m%d_%H%M%S).log
#creates il_emrs_init_check.txt
rc=$?
#rc=0 #test only - could not connect to mail server in test
if [[ $rc != 0 ]] ; then
     echo "exited with status: $rc - IL emrs_Init_check.kjb, aborting run" >> $EMAIL_MESSAGE
     mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
     cat $EMAIL_MESSAGE
     exit $rc
fi
if [[ $rc == 0 ]] ## for testing && -e $INIT_OK ]]
then
   # run the sequence of scripts dependent on each one finishing successfully
   $MAXDAT_ETL_PATH/run_emrs_kjb.sh $EMRSDATADIR/ETL_Load_Dimension_Lookups.kjb ETL_Load_Dimension_Lookups >> $MAXDAT_ETL_LOGS/$MODULE_EMRS/EMRS_Load_Dimension_Lookups_$(date +%Y%m%d_%H%M%S).log
            rc=$?
            if [[ $rc == 0 ]] ; then
               $MAXDAT_ETL_PATH/run_emrs_ktr.sh $EMRSDATADIR/FACT_Load_ENROLLMENTS_HIST.ktr DIM_Load_NOTIFICATIONS >> $MAXDAT_ETL_LOGS/$MODULE_EMRS/EMRS_Load_ENROLLMENTS_HIST_$(date +%Y%m%d_%H%M%S).log 
                  rc=$?
                  if [[ $rc == 0 ]] ; then
                     $MAXDAT_ETL_PATH/run_emrs_ktr.sh $EMRSDATADIR/DIM_Load_ENROLLMENT_NOTIFICATION.ktr DIM_Load_ENROLLMENT_NOTIFICATION >> $MAXDAT_ETL_LOGS/$MODULE_EMRS/EMRS_DIM_Load_ENROLLMENT_NOTIFICATION_$(date +%Y%m%d_%H%M%S).log
   fi
  fi
else
   #mail here, it didn't work, no connectivity
   echo "emrs_init_check.kjb failed in ILEB, review error log for additional detail." >> $EMAIL_MESSAGE
   mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
   cat $EMAIL_MESSAGE
   error_exit "$LINENO: An error has occurred in ILEB. il_emrs_init_load.sh"
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
