#!/bin/ksh
. ~/.bash_profile
. $MAXDAT_ETL_PATH/.setenv_var.sh
#Run_PP_BO_RUNALL.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# =================================================================================

PATH=$KETTLE_NYHIX_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_NYHIX_HOME
#export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

PP_BO_OK="$MAXDAT_ETL_PATH/${STCODE}_run_pp_bo_check.txt"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $PP_BO_OK ]] ; then
   echo "Run Aborted - $PP_BO_OK exists"
   exit;
else
   touch $PP_BO_OK
fi


$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/ProductionPlanning/PP_Back_Office_RUNALL.kjb" -log="$MAXDAT_ETL_LOGS/PP_Back_Office_RUNALL_$(date +%Y%m%d_%H%M%S).LOG" -level="$DETAIL_LOG_LEVEL"

rc=$?
   if [[ $rc != 0 ]] ; then
                                # process failed, abort mission
                                rm -f $PP_BO_OK

   else
                                #success, move on
                                rm -f $PP_BO_OK
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

