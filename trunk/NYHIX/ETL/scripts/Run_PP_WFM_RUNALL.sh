#!/bin/ksh
. ~/.bash_profile
. $MAXDAT_ETL_PATH/.setenv_var.sh
#Run_PP_WFM_RUNALL.sh
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/NYHIX/ETL/scripts/Run_PP_WFM_RUNALL.sh $
# $Revision: 14190 $
# $Date: 2015-04-24 13:36:25 -0400 (Fri, 24 Apr 2015) $
# $Author: pa28085 $
PROGNAME=$(basename $0 .sh)
function error_exit
{

#             ----------------------------------------------------------------
#             Function for exit due to fatal program error
#                             Accepts 1 argument:
#                                             string containing descriptive error message
#             ----------------------------------------------------------------


                echo "${PROGNAME}: ${1:-'Unknown Error'}" 1>&2
                exit 1
}

export KETTLE_HOME=$KETTLE_NYHIX_HOME

#KTR_LOG_LEVEL='Basic'
KJB_LOG_LEVEL='Detailed'

# WFM_OK is also part of the run init check kjb job
WFM_OK="$MAXDAT_ETL_PATH/${STCODE}_run_wfm_runall_check.txt"
#WFM_FAIL="$MAXDAT_ETL_PATH/${STCODE}_run_wfm_runall_fail.txt"

#mail related variables
#EMAIL='MAXDatSystem@maximus.com'
EMAIL='LavanyaGopal@maximus.com'
EMAIL_MESSAGE="/tmp/${2}_${STCODE}-ERROR-LOG.txt"
EMAIL_SUBJECT="${STCODE}-Errors With $2"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $WFM_OK ]] ; then
   echo "Run Aborted - $WFM_OK exists"
   exit;
else
   echo "Starting ${STCODE}_Run_PP_WFM_RUNALL.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE 
   touch $WFM_OK
   if [[ -e $WFM_OK ]] ; then
        echo " $WFM_OK Successfully created!!"
   else
        echo " $WFM_OK Was not Created"
   fi
fi

   $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/PP_WFM_RUNALL.kjb" -log="$MAXDAT_ETL_LOGS/PP_WFM_RUNALL_$(date +%Y%m%d_%H%M%S).LOG" -level="$DETAIL_LOG_LEVEL"
   #$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/NYHIX/ETL/scripts/PP_WFM_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/PP_WFM_RUNALL_$(date +%Y%m%d_%H%M%S).log &
   #$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/ProductionPlanning/PP_Back_Office_RUNALL.kjb" -log="$MAXDAT_ETL_LOGS/PP_Back_Office_RUNALL_$(date +%Y%m%d_%H%M%S).LOG" -level="$DETAIL_LOG_LEVEL"
   
   wait
   
   rc=$?
   if [[ $rc != 0 ]] ; then
                                #a child process failed, abort mission
                                echo "$STCODE - One or more WFM subtasks failed.  Check error logs for more details." >> $EMAIL_MESSAGE
                                rm -f $WFM_OK
                                mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
                                cat $EMAIL_MESSAGE
                                #exit
                                error_exit "$LINENO: $STCODE - WFM error has occurred."
   else
                                #success, move on
                                echo "$STCODE - WFM processes completed successfully."
                                rm -f $WFM_OK
                                exit 0
   fi      


#pan status codes
# 0          The transformation ran without a problem.
# 1          Errors occurred during processing
# 2          An unexpected error occurred during loading / running of the transformation
# 3          Unable to prepare and initialize this transformation
# 7          The transformation couldn't be loaded from XML or the Repository
# 8          Error loading steps or plugins (error in loading one of the plugins mostly)
# 9          Command line usage printing

#kitchen status codes
# 0          The job ran without a problem.
# 1          Errors occurred during processing
# 2          An unexpected error occurred during loading or running of the job
# 7          The job couldn't be loaded from XML or the Repository
# 8          Error loading steps or plugins (error in loading one of the plugins mostly)
# 9          Command line usage printing
