#!/bin/bash
#. ~/.bash_profile
PROGNAME=$(basename $0 .sh)
. /opt/maxdat/FLHK8/scripts/.setenv_var.sh
#set up the environment
LOG_DIR=$MAXDAT_LOG_DIR
MAXDAT_SCRIPT=$MAXDAT_ETL_PATH

#mail related variables
EMAIL="PhilipWSmith@maximus.com"
#EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/weekly_BPM_ERROR.txt"
EMAIL_SUBJECT="Florida weekly BPM error"
sqlplus FLCPD0_MAXDAT/FLCPD0_MAXDAT@FLHKMXDU  <<THEEND 
spool $LOG_DIR/weekly_BPM.sh_log 
whenever sqlerror exit 1;
@$MAXDAT_SCRIPT/analyze_compute.sql
SPOOL OFF

exit; 
THEEND
ERR=$?
if [[ $ERR != 0  ]] ; then
        echo " " >> $EMAIL_MESSAGE
        echo "exited : $ERR - weekly failed" >> $EMAIL_MESSAGE
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
    exit $ERR
fi
exit 0
