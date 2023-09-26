#!/bin/ksh
. ~/.bash_profile
#DLY_NYHIX_Run_Init_MFD.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/NYHIX/ETL/scripts/MFD_Run_Init_DAILY/DLY_nyhix_run_mfd.sh $
# $Revision: 15228 $
# $Date: 2015-09-11 14:19:04 -0500 (Fri, 11 Sep 2015) $
# $Author: pa28085 $
# =================================================================================
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

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
KJB_LOG_ROWLEVEL="Rowlevel"

     $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/MFD_Run_Init_DAILY/DLY_Run_Initialization_MFD.kjb" -level="$KJB_LOG_LEVEL"  >> $MAXDAT_ETL_LOGS/DLY_Run_Init_MFD_$(date +%Y%m%d_%H%M%S).log

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