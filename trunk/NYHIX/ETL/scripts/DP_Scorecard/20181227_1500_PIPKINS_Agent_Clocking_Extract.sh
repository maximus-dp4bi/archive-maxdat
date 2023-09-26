. ~/.bash_profile
#PROGNAME=$(basename $0 .sh)
#function error_exit
#{
#       echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
#       rm -f $INIT_OK
#       exit 1
#}

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"
KJB_LOG_ROWLEVEL="Rowlevel"

#INIT_OK="$MAXDAT_ETL_PATH/${STCODE}Pipkins_Agent_Clocking_Extract.txt"
#CHILD_FAIL="/tmp/${STCODE}_Pipkins_Agent_Clocking_Extract.txt"

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/DP_Scorecard/Pipkins_Agent_Clocking_Extract.kjb" -level="Detailed"  >> $MAXDAT_ETL_LOGS/Pipkins_Agent_Clocking_Extract_$(date +%Y%m%d_%H%M%S).log &
