# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/corp/scripts/run_test_job2.sh $
# $Revision: 25048 $
# $Date: 2018-09-27 11:15:56 -0700 (Thu, 27 Sep 2018) $
# $Author: gt83345 $
# ================================================================================
#!/bin/bash
#set -x
#set -v
#source $MD_SETENV
. ~/.bash_profile

export KETTLE_HOME=$KETTLE_NYHIX_HOME

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
KJB_LOG_ROWLEVEL="Rowlevel"
JOBS_DIR='/u01/maximus/maxdat-uat/NYHIX/ETL/scripts/KillStuckJob'
JOB=test_job2  
#echo $MAXDAT_ETL_PATH
INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_${JOB}_run_check.txt"
#mail related variables
#EMAIL="guydthibodeau@maximus.com"
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_${JOB}_ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE} run_${JOB}.sh in $ENV_CODE"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   exit;
else
   echo "Starting ${STCODE} run_${JOB}.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_OK
fi

#init check
   $MAXDAT_ETL_PATH/run_kjb.sh ${JOBS_DIR}/test_job.kjb $KJB_LOG_LEVEL >> ${MAXDAT_ETL_LOGS}/test_job_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
        echo "exited with status: $rc - test_job.kjb, aborting run in $STCODE" >> $EMAIL_MESSAGE
        rm -f $INIT_OK
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
        exit $rc
fi
 rm -f $INIT_OK
exit 0


