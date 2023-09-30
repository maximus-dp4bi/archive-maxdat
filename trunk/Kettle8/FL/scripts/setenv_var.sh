#----NEW ".setenv_var.sh"-----
# .set_env - [FLHK]
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
export PENTAHO_HOME="/u01/app/appadmin/product/pentaho_8.3"
export PENTAHO_BIN="/u01/app/appadmin/product/pentaho_8.3/data-integration"
export CLASSPATH="/u01/app/appadmin/pentaho_8.3/data-integration"
export HOSTNAME=$(hostname)
export JAVA_HOME="/u01/app/appadmin//jdk1.8.0_192"
export PDI_VERSION="8.3"
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/amazon-corretto-8.342.07.4-linux-x64"
export MAXDAT_KETTLE_DIR="/u01/app/appadmin/product/pentaho_8.3/data-integration"
export MAXDAT_ETL_PATH="/u01/maximus/maxdat/FL/scripts"
export MAXDAT_ETL_LOGS="/u01/maximus/maxdat/FL/logs"
export MAXDAT_LOG_DIR=$MAXDAT_ETL_LOGS
export KETTLE_HOME="/u01/maximus/maxdat/FL"
export KTR_LOG_LEVEL="Basic"
export KJB_LOG_LEVEL="Detailed"
export MAXDAT_ETL_DIR=$MAXDAT_ETL_PATH
PATH="$KETTLE_HOME/.kettle/kettle.properties:.:$PENTAHO_HOME:/usr/bin:/sbin:$PATH"
export PATH
export LD_LIBRARY_PATH=$JAVA_HOME/lib:$PENTAHO_HOME/lib:$ORACLE_HOME/lib:/lib:/usr/lib:/usr/lib64:/usr/X11R6/lib
export SCRIPTS_DIR=$MAXDAT_KETTLE_DIR
export CUSTOM_DIR=$MAXDAT_ETL_PATH
#
#
#mail related variables
export EMAIL="MAXDatSystem@maximus.com"
#
#
# ----  OTHER VARIABLES  ----
export LOG_LIFE_DAYS=30 # Number of days to keep log files in the log directory before deleteing
