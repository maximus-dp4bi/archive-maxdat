#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR
PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"
#---------------------------------
# SVN_FILE_URL        = $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TNRD/scripts/Run_TN_AddressChange_DEV.sh $ 
# SVN_REVISION        = $Revision: 17516 $ 
# SVN_REVISION_DATE   = $Date: 2016-06-17 09:26:13 -0700 (Fri, 17 Jun 2016) $
# SVN_REVISION_AUTHOR = $Author: aa24065 $
#---------------------------------
export PENTAHO_JAVA_HOME='/u01/app/appadmin/product/java/jdk1.6.0_45/'  
export ENV_CODE=dev     #dev,apt,uat,prd
export STCODE=TNRD     #TX,IL,NY,etc
export MAXDAT_KETTLE_DIR='/u01/app/appadmin/product/pentaho_5.2/data-integration'
export MAXDAT_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE/$STCODE/scripts"
export MAXDAT_ETL_LOGS="/u01/maximus/maxdat-$ENV_CODE/$STCODE/logs"
export KETTLE_HOME="/u01/maximus/maxdat-$ENV_CODE/$STCODE/config"


PATH="$KETTLE_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho_5.2/data-integration:/usr/bin:$PATH"
export PATH


SCRIPTS_DIR="/u01/app/appadmin/product/pentaho_5.2/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_PATH/AgencyReports/AddressChange
LOG_DIR=$MAXDAT_ETL_LOGS
LOG_NAME=`echo $0|awk -F"/" '{print substr($NF,1,length($NF)-3)}'`_$(date +%Y%m%d_%H%M%S)
LOG_FILE="${LOG_DIR}/${LOG_NAME}.log"
LOG_LEVEL="Basic" # can be any of the following: Basic Detailed Debugging Rowlevel

export MAXDAT_KETTLE_DIR=/u01/app/appadmin/product/pentaho_5.2/data-integration
export MAXDAT_ETL_DIR=$CUSTOM_DIR

$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/TN_AddressChange_Report_Job.kjb" -log="$LOG_FILE" -level="$LOG_LEVEL"