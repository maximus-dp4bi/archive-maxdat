#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR
PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"
#---------------------------------
# SVN_FILE_URL        = $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/TNRD/scripts/UAT_Run_TN_CIR7.sh $ 
# SVN_REVISION        = $Revision: 22456 $ 
# SVN_REVISION_DATE   = $Date: 2018-02-16 09:05:16 -0800 (Fri, 16 Feb 2018) $
# SVN_REVISION_AUTHOR = $Author: ch136904 $
#---------------------------------
export PENTAHO_JAVA_HOME='/u01/app/appadmin/product/java/jdk1.8.0_144/' 
export ENV_CODE=uat     #dev,apt,uat,prd
export STCODE=TNRD     #TX,IL,NY,etc
export MAXDAT_KETTLE_DIR='/u01/app/appadmin/product/pentaho_7.1/data-integration'
export MAXDAT_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE/$STCODE/scripts"
export MAXDAT_ETL_LOGS="/u01/maximus/maxdat-$ENV_CODE/$STCODE/logs"
export KETTLE_HOME="/u01/maximus/maxdat-$ENV_CODE/$STCODE/config"


PATH="$KETTLE_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho_7.1/data-integration:/usr/bin:$PATH"
export PATH


SCRIPTS_DIR="/u01/app/appadmin/product/pentaho_7.1/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_PATH/AgencyReports/ComprehensiveInventory
LOG_DIR=$MAXDAT_ETL_LOGS
LOG_NAME=`echo $0|awk -F"/" '{print substr($NF,1,length($NF)-3)}'`_$(date +%Y%m%d_%H%M%S)
LOG_FILE="${LOG_DIR}/${LOG_NAME}.log"
LOG_LEVEL="Basic" # can be any of the following: Basic Detailed Debugging Rowlevel

export MAXDAT_KETTLE_DIR=/u01/app/appadmin/product/pentaho_7.1/data-integration
export MAXDAT_ETL_DIR=$CUSTOM_DIR

$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/TN_ComprehensiveInventory_Report_Job7.kjb" -log="$LOG_FILE" -level="$LOG_LEVEL"