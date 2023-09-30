#
#!/bin/ksh
#. ~/.bash_profile
location='/u01/maximus/maxdat/NYHIX8/config'
source ${location}/.set_env

PROGNAME=$(basename $0 .sh)

export KETTLE_HOME=$KETTLE_NYHIX_HOME
export KJB_LOG_LEVEL="Detailed"

$MAXDAT_ETL_PATH/run_kjb.sh $MAXDAT_ETL_PATH/${MODULE_EGAIN}/Egain_Processing_Files.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/${MODULE_EGAIN}/Egain_Process_Files_$(date +%Y%m%d_%H%M%S).log &
