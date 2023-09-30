#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR
PROGNAME=$(basename $0)
#export ENV_CODE="dev"
export ENV_CODE="uat"
#export ENV_CODE="prd"
export STCODE=IL
export IL_SETENV=/u01/maximus/maxdat-$ENV_CODE/$STCODE/ETL/scripts/.setenv_var7.sh
source $IL_SETENV
#Note: this script is runnable without a cronfile
echo "Start of program:  $(basename $0) at $(date +%Y%m%d_%H%M%S)."
#---------------------------------
# SVN_FILE_URL        = $URL$ 
# SVN_REVISION        = $Revision$ 
# SVN_REVISION_DATE   = $Date$
# SVN_REVISION_AUTHOR = $Author$
#---------------------------------
# ---- Override  Generic email variables from setenv  -----
EMAIL='MAXDatSystem@maximus.com'
EMAIL_MESSAGE="/tmp/IL_run_402M_Build_Output7-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With IL_run_402M_Build_Output7.sh in $ENV"
#moving most variables to setenv as part of version 7 upgrade
#ENV='prd'
#export KETTLE_IL_HOME="/u01/maximus/maxdat-${ENV}/IL/config"
#export MAXDAT_ETL_PATH="/u01/maximus/maxdat-${ENV}/IL/ETL"
export ILEB_REPORTS_OUTPUT_DIR="$MAXDAT_ETL_PATH/AgencyReports/working"
#PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho_5.2/data-integration:$PATH
#export PATH
#export KETTLE_HOME=$KETTLE_IL_HOME
#export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"

#SCRIPTS_DIR="/u01/app/appadmin/product/pentaho_5.2/data-integration"
CUSTOM_DIR="$MAXDAT_ETL_PATH/AgencyReports/kettle_5.2/insert_402M_tables"
#LOG_DIR=$MAXDAT_ETL_PATH/logs
#ERR_DIR=$MAXDAT_ETL_PATH/error
#LOG_NAME=`echo $0|awk -F"/" '{print substr($NF,1,length($NF)-3)}'`_$(date +%Y%m%d_%H%M%S)
#LOG_FILE="${LOG_DIR}/${LOG_NAME}.log"
LOG_FILE="$MAXDAT_ETL_LOGS/ILEB_402M_Step_Build_Output${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log"

#LOG_LEVEL="Detailed" # can be any of the following: Basic Detailed Debugging Rowlevel

#export MAXDAT_KETTLE_DIR=/u01/app/appadmin/product/pentaho_5.2/data-integration
export MAXDAT_ETL_DIR=$CUSTOM_DIR
#replacing kitchen.sh with run_kjb7.sh as part of 7 upgrade
#$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ILEB_402M_Step_Build_Output.kjb" -log="$LOG_FILE" -level="$LOG_LEVEL"
$MAXDAT_ETL_PATH/run_kjb7.sh $CUSTOM_DIR/ILEB_402M_Step_Build_Output.kjb $KJB_LOG_LEVEL >> $LOG_FILE
rc=$?
if [[ $rc == 0 ]] ; then
   echo "IL_run_402M_Build_Output7 process completed successfully at $(date +%Y%m%d_%H%M%S)."
else 
   echo "IL_run_402M_Build_Output7 process failed with error code $rc.  See log files for details."
fi
