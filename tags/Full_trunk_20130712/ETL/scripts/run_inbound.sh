#!/bin/bash
. ~/.bash_profile
#run_bpm.sh
PROGNAME=$(basename $0 .sh)
function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

#set up the environment
#PATH=/home/appadmin/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
#export PATH
PATH=$KETTLE_NY_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_NY_HOME


export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
SCRIPTS_DIR="/u01/app/appadmin/product/pentaho/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_DIR
LOG_DIR=$MAXDAT_LOG_DIR
LOG_LEVEL="Detailed"

INIT_INB_OK="$CUSTOM_DIR/run_inbound_check.txt"

#mail related variables
EMAIL2="MAXDatSystem@maximus.com"
EMAIL_MESSAGE2="/tmp/run_inbound-ERROR-LOG.txt"
EMAIL_SUBJECT2="Errors With run_inbound.sh"

#iInobund
if [ -e $INIT_INB_OK ];
then
  echo "run_inbound.sh might currently be running, run_inbound_check.txt exists" >> $EMAIL_MESSAGE2
  mail -s "$EMAIL_SUBJECT2" "$EMAIL2" < $EMAIL_MESSAGE2
  cat $EMAIL_MESSAGE2
  error_exit "$LINENO: An error has occurred. run_inbound.sh"
else
  touch $INIT_INB_OK
  $SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ManageInboundInfo/ManageInbound_Job_Start.kjb" -level="$LOG_LEVEL" >> $LOG_DIR/ManageInbound_Job_Start_$(date +%Y%m%d_%H%M%S).log
  rc=$?
  if [[ $rc != 0 ]] ; then
        rm -f $INIT_INB_OK
	echo "exited with status: $rc - ManageInbound_Job_Start.kjb, aborting run" >> $EMAIL_MESSAGE2
	mail -s "$EMAIL_SUBJECT2" "$EMAIL2" < $EMAIL_MESSAGE2
	cat $EMAIL_MESSAGE2
    exit $rc
  else    
    #success, move on
      echo "Inbound process completed successfully."
      rm -f $INIT_INB_OK
      exit 0
  fi
fi
