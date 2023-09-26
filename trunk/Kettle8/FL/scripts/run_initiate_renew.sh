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
PATH=$KETTLE_FL_HOME/.kettle/kettle.properties:.:/home/pentaho/design-tools/data-integration:$PATH
export PATH
export KETTLE_HOME=$KETTLE_FL_HOME
export PENTAHO_JAVA_HOME="/opt/tools/jdk1.7.0/jre/"
SCRIPTS_DIR="/home/pentaho/design-tools/data-integration"
CUSTOM_DIR=$MAXDAT_ETL_DIR
LOG_DIR=$MAXDAT_LOG_DIR
LOG_LEVEL="Detailed"

INIT_REN_OK="$CUSTOM_DIR/run_init_renew_check.txt"

#mail related variables
EMAIL2="PhilipWSmith1@maximus.com"
EMAIL_MESSAGE2="/tmp/run_initiate_renew-ERROR-LOG.txt"
EMAIL_SUBJECT2="Errors With run_initiate_renew.sh"

#init Renew
if [ -e $INIT_REN_OK ];
then
  echo "run_initiate_renew.sh might currently be running, run_init_renew_check.txt exists" >> $EMAIL_MESSAGE2
  mail -s "$EMAIL_SUBJECT2" "$EMAIL2" < $EMAIL_MESSAGE2
  cat $EMAIL_MESSAGE2
  error_exit "$LINENO: An error has occurred. run_initiate_renew.sh"
else
  touch $INIT_REN_OK
  $SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/InitiateRenewals/InitiateRenewals_Runall.kjb" -level="$LOG_LEVEL"  >> $LOG_DIR/InitiateRenewals_RUNALL_$(date +%Y%m%d_%H%M%S).log
  rc=$?
  if [[ $rc != 0 ]] ; then
        rm -f $INIT_REN_OK
	echo "exited with status: $rc - InitiateRenewal_RUNALL.kjb, aborting run" >> $EMAIL_MESSAGE2
	mail -s "$EMAIL_SUBJECT2" "$EMAIL2" < $EMAIL_MESSAGE2
	cat $EMAIL_MESSAGE2
    exit $rc
  else    
    #success, move on
      echo "IR process completed successfully."
      rm -f $INIT_REN_OK
      exit 0
  fi
fi
