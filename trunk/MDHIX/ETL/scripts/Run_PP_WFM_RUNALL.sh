#!/bin/bash
. ~/.bash_profile
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/MDHIX/ETL/scripts/PP_WFM_RUNALL.sh $
# $Revision: 10689 $
# $Date: 2015-05-22 16:24:52 -0700 (Thu, 19 Mar 2015) $
# $Author: sk51922 $
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	rm -f $INIT_OK
	exit 1
}

BASEDIR=$(dirname $0)
echo $BASEDIR
. $MAXDAT_ETL_PATH/MDHIX/ETL/scripts/ContactCenter/implementation/MDHIX/bin/set_env_vars.sh
# This program will run the Kettle job that executes adhoc jobs

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

JOBS_DIR=$MAXDAT_ETL_PATH
JOB=PP_WFM_RUNALL
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

# email-related variables
EMAIL="SaraswathiKonidena@maximus.com"
EMAIL_MESSAGE="$ERR_DIR/$INIT_JOB_ERROR_LOG.log"
EMAIL_SUBJECT="Errors with $INIT_JOB"

LOG_DIR=$MAXDAT_ETL_LOGS
echo $LOG_DIR
LOG_LEVEL="Detailed"

PP_WFM_OK="$MAXDAT_ETL_PATH/${STCODE}_run_pp_wfm_check.txt"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $PP_WFM_OK ]] ; then
   echo "Run Aborted - $PP_WFM_OK exists"
   exit;
else
   touch $PP_WFM_OK
fi

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"

wait
   
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
   


