#----NEW ".setenv_var.sh"-----
# .set_env - [SITE]
# corp_set_env.txt
# =======================================================================
# Do not edit these four SVN_* variable values.  They are populated when
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/NYEC7/scripts/.setenv_var7.sh $
# $Revision: 21202 $
# $Date: 2017-09-14 16:17:40 -0600 (Thu, 14 Sep 2017) $
# $Author: iv136523 $
# =======================================================================
#
# Set all of the exported environment variables in this file
# All lines marked with a "->" need to be set for the local server (and the "->" removed)
# -----  MAXDAT VARIABLES  ----
export HOSTNAME=$(hostname)
#export ENV_CODE="dev" - moved to cronfile
export ENV_CODE="uat"
#export ENV_CODE="prd"- moved to cronfile
export STCODE=NYEC
export PENTAHO_JAVA_HOME='/u01/app/appadmin/product/java/jdk1.6.0_31'
export MAXDAT_KETTLE_DIR='/u01/app/appadmin/product/pentaho/data-integration'
export MAXDAT_ETL_DIR="/u01/maximus/maxbi-uat"
export MAXDAT_LOG_DIR="/u01/maximus/maxbi-uat/ETL/logs"
export MAXDAT_ETL_PATH="/u01/maximus/maxbi-uat/ETL/"
export MAXDAT_ETL_LOGS="/u01/maximus/maxbi-uat/ETL/logs"
export KETTLE_NY_HOME="/home/appadmin"
export KETTLE_HOME="/home/appadmin"
export KTR_LOG_LEVEL='Basic'
export KJB_LOG_LEVEL='Detailed'
export INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_check.txt"
export CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"
export PATH="$KETTLE_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration:/usr/bin:$PATH"
export EMAIL_MESSAGE="/tmp/${STCODE}_kettle-ERROR-LOG.txt"
export EMAIL_SUBJECT="Errors With ${STCODE}_Kettle.sh in $ENV_CODE"
#
# ----  P-PLANNING VARIABLES  ----
export PLANNING_OK="$MAXDAT_ETL_PATH/${STCODE}_run_planning_check${PDI_VERSION}.txt"
export PLANNING_FAIL="$MAXDAT_ETL_PATH/${STCODE}_child_planning_fail${PDI_VERSION}.txt"
#
# ----  OTHER VARIABLES  ----
export LOG_LIFE_DAYS=30 # Number of days to keep log files in the log directory before deleteing
