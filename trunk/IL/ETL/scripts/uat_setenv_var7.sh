#----NEW ".setenv_var7.sh"-----
# .set_env - [SITE]
# corp_set_env.txt
# =======================================================================
# Do not edit these four SVN_* variable values.  They are populated when
#    you commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# =======================================================================
#
# Set all of the exported environment variables in this file
# All lines marked with a "->" need to be set for the local server (and the "->" removed)
# -----  MAXDAT VARIABLES  ----
export HOSTNAME=$(hostname)
#export ENV_CODE="dev" - moved to cronfile
#export ENV_CODE="uat"- moved to cronfile
#export ENV_CODE="prd"- moved to cronfile
#export STCODE=IL- moved to cronfile
export PDI_VERSION='7'
export PENTAHO_JAVA_HOME='/u01/app/appadmin/product/java/jdk1.8.0_144/'
export MAXDAT_KETTLE_DIR='/u01/app/appadmin/product/pdi-ce-7.1.0.0-12/data-integration'
export MAXDAT_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE/$STCODE/ETL/scripts"
export MAXDAT_ETL_LOGS="/u01/maximus/maxdat-$ENV_CODE/$STCODE/ETL/logs"
export KETTLE_HOME="/u01/maximus/maxdat-$ENV_CODE/$STCODE/config"
export KTR_LOG_LEVEL='Basic'
export KJB_LOG_LEVEL='Detailed'
export INIT_OK="$MAXDAT_ETL_PATH/${STCODE}_PDI${PDI_VERSION}_run_check.txt"
export CHILD_FAIL="/tmp/${STCODE}_PDI${PDI_VERSION}_child_task_fail.txt"
export PENTAHO_DI_JAVA_OPTIONS='-Djava.security.egd=file:/dev/./urandom'
PATH="$KETTLE_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pdi-ce-7.1.0.0-12/data-integration:/usr/bin:$PATH"
export PATH
#
# ----  EMRS VARIABLES  -----
#export EINIT_OK="$MAXDAT_ETL_PATH/${STCODE}_emrs_init_check.txt"
#export EMRS_DATA_DIR=$MAXDAT_ETL_PATH/EnrollmentDataEMRS
#
# ----  MAIL VARIABLES  -----
#mail related variables
export EMAIL='MAXDatSystem@maximus.com'
export EMAIL_MESSAGE="/tmp/${STCODE}_kettle-ERROR-LOG${PDI_VERSION}.txt"
export EMAIL_SUBJECT="Errors With ${STCODE}_Kettle.sh in $ENV_CODE"
#
# ----  P-PLANNING VARIABLES  ----
export PLANNING_OK="$MAXDAT_ETL_PATH/${STCODE}_run_planning_check${PDI_VERSION}.txt"
export PLANNING_FAIL="$MAXDAT_ETL_PATH/${STCODE}_child_planning_fail${PDI_VERSION}.txt"
#
# ----  OTHER VARIABLES  ----
export LOG_LIFE_DAYS=30 # Number of days to keep log files in the log directory before deleteing
