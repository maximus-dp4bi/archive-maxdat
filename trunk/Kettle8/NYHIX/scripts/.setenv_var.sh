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
export HOSTNAME=`hostname`
case $HOSTNAME in
"ucocdmmetl01nhx.maxcorp.maximus")
  export ENV_CODE="dev"
  ;;
"ucocummapp11nhx.maxcorp.maximus")
  export ENV_CODE="uat"
  ;;
"uvacpmmetl04nhx.maxcorp.maximus")
  export ENV_CODE="prd"
  ;;
esac
export STCODE=NYHIX
export PENTAHO_JAVA_HOME='/u01/app/appadmin/product/java/jdk1.6.0_45'
export MAXDAT_KETTLE_DIR='/u01/app/appadmin/product/data-integration'
export MAXDAT_ETL_DIR="/u01/maximus/maxdat-${ENV_CODE}/${STCODE}"
export MAXDAT_LOG_DIR="$MAXDAT_ETL_DIR/ETL/logs"
export MAXDAT_ETL_PATH="$MAXDAT_ETL_DIR/ETL/scripts"
export MAXDAT_ETL_LOGS="$MAXDAT_LOG_DIR"
export KETTLE_NYHIX_HOME=/u01/maximus/maxdat-${ENV_CODE}/${STCODE}/config
export KETTLE_HOME="/home/appadmin"
export KTR_LOG_LEVEL='Basic'
export KJB_LOG_LEVEL='Detailed'
export INIT_OK="$MAXDAT_ETL_DIR/${STCODE}_run_check.txt"
export CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"
export PATH="$KETTLE_NYHIX_HOME/.kettle/kettle.properties:.:$PENTAHO_JAVA_HOME:/usr/bin:$PATH"
export EMAIL_MESSAGE="/tmp/${STCODE}_kettle-ERROR-LOG.txt"
export EMAIL_SUBJECT="Errors With ${STCODE}_Kettle.sh in $ENV_CODE"

