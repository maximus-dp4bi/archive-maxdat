#!/bin/bash
# set_env.sh
# =======================================================================
# Do not edit these four SVN_* variable values.  They are populated when 
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/PAIEB/ETL/scripts/dev_set_env8.sh $
# $Revision: 25784 $
# $Date: 2018-12-18 14:05:01 -0600 (Tue, 18 Dec 2018) $
# $Author: aa24065 $
# =======================================================================
#
# Set all of the exported environment variables in this file
# All lines marked with a "->" need to be set for the local server (and the "->" removed)
# -----  MAXDAT VARIABLES  ----
export ENV_CODE=dev
export STCODE=PAIEB8
export PDI_VERSION='8'
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.8.0_192"
export MAXDAT_KETTLE_DIR="/u01/app/appadmin/product/pentaho_8.2/data-integration"
export MAXDAT_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE/$STCODE/scripts"
export MAXDAT_ETL_LOGS="/u01/maximus/maxdat-$ENV_CODE/$STCODE/logs"
export KETTLE_HOME="/u01/maximus/maxdat-$ENV_CODE/$STCODE/config"
export KTR_LOG_LEVEL='Basic'
export KJB_LOG_LEVEL='Detailed'
export INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_PDI${PDI_VERSION}_run_check.txt"
export CHILD_FAIL="/tmp/${STCODE}_PDI${PDI_VERSION}_child_task_fail.txt"
export PENTAHO_DI_JAVA_OPTIONS='-Djava.security.egd=file:/dev/./urandom'
PATH="$KETTLE_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho_8.2/data-integration:/usr/bin:$PATH"

#
#PATH="$KETTLE_HOME/.kettle/kettle.properties:.:$MAXDAT_KETTLE_DIR:/usr/bin:$PATH"
export PATH
#
# ----  EMRS VARIABLES  -----
export EINIT_OK="$MAXDAT_ETL_PATH/${STCODE}_emrs_init_check.txt"
export EMRS_DATA_DIR=$MAXDAT_ETL_PATH/EnrollmentDataEMRS
#
# ----  MAIL VARIABLES  -----
#mail related variables
export EMAIL='MAXDatSystem@maximus.com'
export EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
export EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm.sh in $ENV_CODE"
#
# ----  P-PLANNING VARIABLES  ----
export PLANNING_OK="$MAXDAT_ETL_PATH/${STCODE}_run_planning_check.txt"
export PLANNING_FAIL="$MAXDAT_ETL_PATH/${STCODE}_child_planning_fail.txt"
#
# ----  OTHER VARIABLES  ----
export LOG_LIFE_DAYS=90 # Number of days to keep log files in the log directory before deleteing