#!/bin/bash
# set_env.sh
# =======================================================================
# Do not edit these four SVN_* variable values.  They are populated when 
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/PA/set_env.sh $
# $Revision: 23596 $
# $Date: 2018-06-01 13:38:14 -0400 (Fri, 01 Jun 2018) $
# $Author: TM151500 $
# =======================================================================
#
# Set all of the exported environment variables in this file
# All lines marked with a "->" need to be set for the local server (and the "->" removed)
# -----  MAXDAT VARIABLES  ----
export ENV_CODE=uat
export STCODE=PAIECC8
export PDI_VERSION='8'
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.8.0_192"
export MAXDAT_KETTLE_DIR="/u01/app/appadmin/product/pentaho_8.3/data-integration"
export KETTLE_PAIE_HOME="/u01/maximus/maxdat-$ENV_CODE/$STCODE/config"
export KETTLE_HOME=$KETTLE_PAIE_HOME
export KTR_LOG_LEVEL='Basic'
export KJB_LOG_LEVEL='Detailed'
export CHILD_FAIL="/tmp/${STCODE}_PDI${PDI_VERSION}_child_task_fail.txt"
PATH="$KETTLE_PAIE_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho_8.3/data-integration:/usr/bin:$PATH"
export PATH
export KETTLE_JNDI_ROOT=$KETTLE_PAIE_HOME/simple-jndi
MAXDAT_ETL_PATH=/u01/maximus/maxdat-$ENV_CODE
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/logs
export MAXDAT_MOTS_FILES=$MAXDAT_ETL_PATH/$STCODE/mots/files
export MAXDAT_ETL_PATH=/u01/maximus/maxdat-$ENV_CODE/$STCODE/scripts

#
# ----  MAIL VARIABLES  -----
#mail related variables
export EMAIL='MAXDatSystem@maximus.com'
export EMAIL_MESSAGE="/tmp/${STCODE}_kettle-ERROR-LOG${PDI_VERSION}.txt"
export EMAIL_SUBJECT="Errors With ${STCODE}_Kettle.sh in $ENV_CODE"
#
# ----  P-PLANNING VARIABLES  ----
export PLANNING_OK="$MAXDAT_ETL_PATH/${STCODE}_run_planning_check.txt"
export PLANNING_FAIL="$MAXDAT_ETL_PATH/${STCODE}_child_planning_fail.txt"
#
# ----  OTHER VARIABLES  ----
export LOG_LIFE_DAYS=90 # Number of days to keep log files in the log directory before deleteing
