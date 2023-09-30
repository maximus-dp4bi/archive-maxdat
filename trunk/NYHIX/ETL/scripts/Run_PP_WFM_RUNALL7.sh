#!/bin/ksh
#. ~/.bash_profile

# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# =================================================================================

PROGNAME=$(basename $0 .sh)
function error_exit
{

#       ----------------------------------------------------------------
#       Function for exit due to fatal program error
#               Accepts 1 argument:
#                       string containing descriptive error message
#       ----------------------------------------------------------------


        echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
        exit 1
}



PP_WFM_OK="$MAXDAT_ETL_PATH/${STCODE}_run_pp_wfm_check.txt"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $PP_WFM_OK ]] ; then
   echo "Run Aborted - $PP_WFM_OK exists"
   exit;
else
   touch $PP_WFM_OK
fi

$MAXDAT_ETL_PATH/run_kjb7.sh  $MAXDAT_ETL_PATH/PP_WFM_RUNALL.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/PP_WFM_RUNALL7_$(date +%Y%m%d_%H%M%S).LOG

rc=$?
   if [[ $rc != 0 ]] ; then
                                # process failed, abort mission
                                rm -f $PP_WFM_OK

   else
                                #success, move on
                                rm -f $PP_WFM_OK
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