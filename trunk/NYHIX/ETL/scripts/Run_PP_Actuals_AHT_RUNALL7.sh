#!/bin/ksh
#. ~/.bash_profile


# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
PROGNAME=$(basename $0 .sh)
function error_exit
{

#       ----------------------------------------------------------------
#       Function for exit due to fatal program error
#               Accepts 1 argument:
#                       string containing descriptive error message
#       ----------------------------------------------------------------


        echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
        rm -f $INIT_OK
        exit 1
}

#mail related variables
EMAIL="nickvirdi@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm7-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm7.sh in $ENV_CODE"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   exit;
else
   echo "Starting ${STCODE}_run_bpm7.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_OK
fi



$MAXDAT_KETTLE_PATH/run_kjb7.sh $MAXDAT_ETL_PATH/ProductionPlanning/Actuals_AHT_Staff_Hours/PP_Actuals_ATH_RUNALL.kjb $KJB_LOG_LEVEL >>  $MAXDAT_ETL_LOGS/PP_Actuals_AHT_RUNALL$(date +%Y%m%d_%H%M%S).LOG

