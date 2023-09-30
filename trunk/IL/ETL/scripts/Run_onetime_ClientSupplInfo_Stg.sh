#!/bin/bash
. ~/.bash_profile

#Complete the environment - Specific to IL only
#---------------------------
#redefining these paths here to keep them separate frm NY
export STCODE=IL
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/ETL/logs
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/$STCODE/ETL/scripts
PATH=$KETTLE_IL_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_IL_HOME
#--------------------------

KTR_LOG_LEVEL="Basic"
KJB_LOG_LEVEL="Detailed"

$MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_PATH/Load_Client_Supplementary_Info_Stg_Onetime.ktr" -level="$KJB_LOG_LEVEL"  > $MAXDAT_ETL_LOGS/Load_Client_Supplementary_Info_Stg_Onetime_$(date +%Y%m%d_%H%M%S).log

