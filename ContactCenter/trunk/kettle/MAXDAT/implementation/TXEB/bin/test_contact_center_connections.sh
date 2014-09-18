!/bin/bash
. ~/.bash_profile

# tx_run_cc.sh
# This program will run the Kettle job necessary to initialize the Contact Center data mart

PROGNAME=$(basename $0)
echo "Start of program:  $(basename $0)"

#Complete the environment - Specific to IL only
#---------------------------
#redefining these paths here to keep them separate from NY
#export STCODE=IL
#export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/ETL/logs
#export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/$STCODE/ETL/scripts
#PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
#export KETTLE_HOME=$KETTLE_IL_HOME
#--------------------------

JOBS_DIR=$MAXDAT_ETL_PATH/ContactCenter/test/jobs
JOB=test_contact_center_connections
echo $MAXDAT_ETL_PATH
echo $JOBS_DIR

BASIC_LOG_LEVEL="Basic"
DETAIL_LOG_LEVEL="Detailed"

LOG_DIR=$MAXDAT_ETL_LOGS/ContactCenter
echo $LOG_DIR
LOG_LEVEL="Detailed"

sh $MAXDAT_KETTLE_DIR/kitchen.sh -file="$JOBS_DIR/$JOB.kjb" -level="$LOG_LEVEL"  >> "$LOG_DIR/$JOB$(date +%Y%m%d_%H%M%S).log"
