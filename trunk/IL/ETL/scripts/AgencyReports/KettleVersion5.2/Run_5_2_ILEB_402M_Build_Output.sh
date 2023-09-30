#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR
PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"
#---------------------------------
# SVN_FILE_URL        = $URL$ 
# SVN_REVISION        = $Revision$ 
# SVN_REVISION_DATE   = $Date$
# SVN_REVISION_AUTHOR = $Author$
#---------------------------------
ENV='prd'
export KETTLE_IL_HOME="/u01/maximus/maxdat-${ENV}/IL/config"
export MAXDAT_ETL_PATH="/u01/maximus/maxdat-${ENV}/IL/ETL"
export ILEB_REPORTS_OUTPUT_DIR="$MAXDAT_ETL_DIR/scripts/AgencyReports/working"
PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho_5.2/data-integration:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME
export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"

SCRIPTS_DIR="/u01/app/appadmin/product/pentaho_5.2/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_PATH/scripts/AgencyReports/kettle_5.2/insert_402M_tables
LOG_DIR=$MAXDAT_ETL_PATH/logs
ERR_DIR=$MAXDAT_ETL_PATH/error
LOG_NAME=`echo $0|awk -F"/" '{print substr($NF,1,length($NF)-3)}'`_$(date +%Y%m%d_%H%M%S)
LOG_FILE="${LOG_DIR}/${LOG_NAME}.log"
LOG_LEVEL="Detailed" # can be any of the following: Basic Detailed Debugging Rowlevel

export MAXDAT_KETTLE_DIR=/u01/app/appadmin/product/pentaho_5.2/data-integration
export MAXDAT_ETL_DIR=$CUSTOM_DIR

$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ILEB_402M_Step_Build_Output.kjb" -log="$LOG_FILE" -level="$LOG_LEVEL"

