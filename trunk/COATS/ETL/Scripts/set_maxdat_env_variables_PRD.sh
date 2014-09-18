# .set_env - COATS 
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code.
# $URL: $
# $Revision: $
# $Date: $
# $Author: $


export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
export ENV_CODE="PRD"
export STCODE=CO
export MAXDAT_KETTLE_DIR='/u01/app/appadmin/product/pentaho/data-integration'
export MAXDAT_ETL_PATH="/u01/maximus/maxdat-prd/CO/ETL/scripts"
export MAXDAT_ETL_LOGS="/u01/maximus/maxdat-prd/CO/ETL/logs"
export KETTLE_HOME="/u01/maximus/maxdat-prd/CO/config"
export KTR_LOG_LEVEL='Basic'
export KJB_LOG_LEVEL='Detailed'
export INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_check.txt"
#export CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt" <--Not applicable to one module
export PLANNING_OK="$MAXDAT_ETL_PATH/${STCODE}_run_planning_check.txt"
export PLANNING_FAIL="$MAXDAT_ETL_PATH/${STCODE}_child_planning_fail.txt"
export EMAIL='MAXDatSystem@maximus.com'
export EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
export EMAIL_SUBJECT="Errors With coats_run_bpm.sh in $ENV_CODE"
export LOG_LIFE_DAYS=30

PATH="$KETTLE_HOME/.kettle/:.:/u01/app/appadmin/product/pentaho/data-integration/:/usr/bin:$PATH"
export PATH
