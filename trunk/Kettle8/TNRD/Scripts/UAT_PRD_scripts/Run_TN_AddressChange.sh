#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR
PROGNAME=$(basename $0)
source /u01/maximus/maxdat-uat/TNRD8/scripts/.set_env
echo "Start of program:  $(basename $0)"
#---------------------------------
# SVN_FILE_URL        = $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TNRD/scripts/Run_TN_AddressChange_PRD.sh $ 
# SVN_REVISION        = $Revision: 17516 $ 
# SVN_REVISION_DATE   = $Date: 2016-06-17 09:26:13 -0700 (Fri, 17 Jun 2016) $
# SVN_REVISION_AUTHOR = $Author: aa24065 $
#---------------------------------
CUSTOM_DIR=$MAXDAT_ETL_PATH/AgencyReports/AddressChange
LOG_DIR=$MAXDAT_ETL_LOGS
LOG_NAME=`echo $0|awk -F"/" '{print substr($NF,1,length($NF)-3)}'`_$(date +%Y%m%d_%H%M%S)
LOG_FILE="${LOG_DIR}/${LOG_NAME}.log"

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$CUSTOM_DIR/TN_AddressChange_Report_Job.kjb" -log="$LOG_FILE" -level="$KTR_LOG_LEVEL"