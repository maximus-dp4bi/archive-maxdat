#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR
PROGNAME=$(basename $0)
echo "Start $(basename $0) at $(date +%Y%m%d_%H%M%S)"
#---------------------------------
# SVN_FILE_URL        = $URL$
# SVN_REVISION        = $Revision$
# SVN_REVISION_DATE   = $Date$
# SVN_REVISION_AUTHOR = $Author$
#---------------------------------
#ENV='prd'
# ---- Override  Generic email variables from setenv  -----
#EMAIL="CameronHill@maximus.com"
EMAIL_MESSAGE="/tmp/IL_run_402_7-ERROR-LOG.txt"
EMAIL_SUBJECT="Errors With IL_run_402_7.sh in $ENV"
#moving most variables to setenv as part of version 7 upgrade
#export KETTLE_IL_HOME="/u01/maximus/maxdat-${ENV}/IL/config"
#export MAXDAT_ETL_PATH="/u01/maximus/maxdat-${ENV}/IL/ETL"
export ILEB_REPORTS_OUTPUT_DIR="$MAXDAT_ETL_PATH/AgencyReports/working"
#PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho_5.2/data-integration:$PATH
#export PATH
#export KETTLE_HOME=$KETTLE_IL_HOME
#export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"

#SCRIPTS_DIR="/u01/app/appadmin/product/pentaho_5.2/data-integration"
CUSTOM_DIR="$MAXDAT_ETL_PATH/AgencyReports/kettle_5.2/insert_402_tables"
#LOG_DIR=$MAXDAT_ETL_PATH/logs
#ERR_DIR=$MAXDAT_ETL_PATH/error
#LOG_NAME=`echo $0|awk -F"/" '{print substr($NF,1,length($NF)-3)}'`_$(date +%Y%m%d_%H%M%S)
LOG_FILE="$MAXDAT_ETL_LOGS/ILEB_402_Step_Build_Output_${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log"
#LOG_LEVEL="Debugging" # can be any of the following: Basic Detailed Debugging Rowlevel

#export MAXDAT_KETTLE_DIR=/u01/app/appadmin/product/pentaho_5.2/data-integration
#export MAXDAT_ETL_DIR=$CUSTOM_DIR
#replace kitchen.sh with run_kjb7.sh as part of version 7 upgrade
#$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ILEB_402_Step_Build_Output.kjb" -log="$LOG_FILE" -level="$LOG_LEVEL"
$MAXDAT_ETL_PATH/run_kjb7.sh $CUSTOM_DIR/ILEB_402_Step_Build_Output.kjb $KJB_LOG_LEVEL >> $LOG_FILE

CUSTOM_DIR="$MAXDAT_ETL_PATH/AgencyReports/kettle_5.2/create_402_report"
export MAXDAT_ETL_DIR=$CUSTOM_DIR

#replace kitchen.sh with run_kjb7.sh as part of version 7 upgrade
#$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ILEB_402_Write_Output_Only.kjb" -log="$LOG_FILE" -level="$LOG_LEVEL"
LOG_FILE="$MAXDAT_ETL_LOGS/ILEB_402_Write_Output_Only_${PDI_VERSION}_$(date +%Y%m%d_%H%M%S).log"

$MAXDAT_ETL_PATH/run_kjb7.sh $CUSTOM_DIR/ILEB_402_Write_Output_Only.kjb $KJB_LOG_LEVEL >> $LOG_FILE

rc=$?
if [[ $rc == 0 ]] ; then
   echo "IL_run_402_7 process completed successfully at $(date +%Y%m%d_%H%M%S)."
else 
   echo "IL_run_402_7 process failed with error code $rc.  See log files for details."
fi

