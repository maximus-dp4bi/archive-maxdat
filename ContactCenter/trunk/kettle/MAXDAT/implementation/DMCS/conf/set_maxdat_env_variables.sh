#!/bin/sh
. ~/.bash_profile

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_45"
export ENV_CODE="prd"
export STCODE=DMCS
export MAXDAT_KETTLE_DIR='/u01/app/appadmin/product/pentaho/data-integration'
export MAXDAT_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE/$STCODE/ETL/scripts"
export MAXDAT_ETL_LOGS="/u01/maximus/maxdat-$ENV_CODE/$STCODE/ETL/logs"
export KETTLE_DMCS_HOME="/u01/maximus/maxdat-$ENV_CODE/$STCODE/config"
export KETTLE_HOME=$KETTLE_DMCS_HOME
export KTR_LOG_LEVEL='Basic'
export KJB_LOG_LEVEL='Detailed'
export INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_run_check.txt"
export CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"
export EMAIL='MAXDatSystem@maximus.com'
export EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
export EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm.sh in $ENV_CODE"

PATH="$KETTLE_DMCS_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:/usr/bin:$PATH"
export PATH

