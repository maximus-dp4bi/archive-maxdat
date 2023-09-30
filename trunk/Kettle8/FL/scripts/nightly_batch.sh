#!/bin/bash
. ~/.bash_profile
#run_bpm.sh
#. /opt/maxdat/FLHK8/scripts/.setenv_var.sh
PROGNAME=$(basename $0 .sh)
function error_exit
{

#       ----------------------------------------------------------------
#       Function for exit due to fatal program error
#               Accepts 1 argument:
#                       string containing descriptive error message
#       ----------------------------------------------------------------


        echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
        exit 1
}
#mail related variables
#EMAIL="PhilipWSmith@maximus.com"
EMAIL="MAXDatSystem@maximus.com"
EMAIL_MESSAGE="/tmp/weekly_BPM_ERROR.txt"
EMAIL_SUBJECT="Florida weekly BPM error"
sqlplus FLCPD0_VIDA/flcpd0$v2d0@DB<<THEEND 
<<EOF
    exec FLCPD0_STAGE.sp_load_stage;
    / 
    exec FLCPD0_REPORTS.sp_load_reports;
    /
    exec FLCPD0_REPORTS.sp_load_letter_viewed;
    /
exit
EOF

THEEND
exit; 
ERR=$?
if [[ $ERR != 0  ]] ; then
        echo " " >> $EMAIL_MESSAGE
        echo "exited : $ERR - weekly failed" >> $EMAIL_MESSAGE
        mail -s "$EMAIL_SUBJECT" "$EMAIL" < $EMAIL_MESSAGE
        cat $EMAIL_MESSAGE
    exit $ERR
fi
exit 0
