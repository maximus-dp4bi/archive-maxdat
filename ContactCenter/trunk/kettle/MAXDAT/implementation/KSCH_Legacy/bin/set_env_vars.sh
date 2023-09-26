#!/bin/bash

. ~/.bash_profile

#Complete the environment - Specific to KSCH_Legacy only
#---------------------------
#redefining these paths here to keep them separate frm CO
export STCODE=KSCH_Legacy
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/logs
export MAXDAT_MOTS_FILES=$MAXDAT_ETL_PATH/$STCODE/mots/files
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/$STCODE/scripts
PATH=$KETTLE_KSCH_Legacy_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_KSCH_Legacy_HOME
#--------------------------
