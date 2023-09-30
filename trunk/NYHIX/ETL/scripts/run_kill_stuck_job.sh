# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/corp/scripts/run_kill_stuck_job.sh $
# $Revision: 25035 $
# $Date: 2018-09-27 08:09:31 -0700 (Thu, 27 Sep 2018) $
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
JOB=Kill_stuck_jobs  
#echo $MAXDAT_ETL_PATH
INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_${JOB}_run_check.txt"
#mail related variables
#EMAIL="guydthibodeau@maximus.com"
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/${STCODE}_${JOB}_ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With ${STCODE} kill_stuck_job.sh in $ENV_CODE"

#checking for run file, Abort if it exists, create if it does not exists
if [[ -e $INIT_OK ]] ; then
   echo "Run Aborted - $INIT_OK exists"
   exit;
else
   echo "Starting ${STCODE} kill_stuck_job.sh in ${ENV_CODE}."
   rm -f $EMAIL_MESSAGE $CHILD_FAIL
   touch $INIT_OK
fi

#init check
   ${MAXDAT_KETTLE_DIR}/kitchen.sh -file="${JOBS_DIR}/${JOB}.kjb" -level="$KJB_LOG_LEVEL" >> ${MAXDAT_ETL_LOGS}/${JOB}_$(date +%Y%m%d_%H%M%S).log
rc=$?
if [[ $rc != 0 ]] ; then
        echo "exited with status: $rc - ${JOB}.kjb, aborting run in $STCODE" >> $EMAIL_MESSAGE
        rm -f $INIT_OK
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
        exit $rc
fi
 rm -f $INIT_OK
exit 0


