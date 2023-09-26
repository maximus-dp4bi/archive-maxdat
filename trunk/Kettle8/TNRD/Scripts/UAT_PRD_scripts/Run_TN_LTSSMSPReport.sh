#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR
PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"
#---------------------------------
# SVN_FILE_URL        = $URL: svn://rcmxapp1d.maximus.com/maxdat/trunk/TNRD/scripts/Run_TN_LTSSMSPReport_UAT.sh $ 
# SVN_REVISION        = $Revision: 22056 $ 
# SVN_REVISION_DATE   = $Date: 2017-12-27 15:11:48 -0700 (Wed, 27 Dec 2017) $
# SVN_REVISION_AUTHOR = $Author: aa24065 $
#---------------------------------
CUSTOM_DIR=$MAXDAT_ETL_PATH/AgencyReports/LTSSMSPReport
LOG_DIR=$MAXDAT_ETL_LOGS
LOG_NAME=`echo $0|awk -F"/" '{print substr($NF,1,length($NF)-3)}'`_$(date +%Y%m%d_%H%M%S)
LOG_FILE="${LOG_DIR}/${LOG_NAME}.log"

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$CUSTOM_DIR/TN_LTSSMSP_Report_Job.kjb" -log="$LOG_FILE" -level="$KTR_LOG_LEVEL"