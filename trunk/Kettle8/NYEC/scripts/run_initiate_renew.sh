#!/bin/bash
source /u01/maximus/maxdat/NYEC8/config/.set_env
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


INIT_REN_OK="$CUSTOM_DIR/run_init_renew_check.txt"

#mail related variables
EMAIL2="MAXDatSystem@maximus.com"
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
  $MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_DIR/$MODULE_IR/InitiateRenewal_RUNALL.kjb" -level="$LOG_LEVEL"  >> $MAXDAT_LOG_DIR/$MODULE_IR/InitiateRenewal_RUNALL_$(date +%Y%m%d_%H%M%S).log
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
