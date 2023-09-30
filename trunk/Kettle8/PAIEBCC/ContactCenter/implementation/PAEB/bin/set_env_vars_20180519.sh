#!/bin/bash

. ~/.bash_profile

#Complete the environment - Specific to ILEBCC only
#---------------------------
#redefining these paths here to keep them separate frm NY
export STCODE=PA
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/logs
export MAXDAT_MOTS_FILES=$MAXDAT_ETL_PATH/$STCODE/mots/files
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/$STCODE/scripts
PATH=$KETTLE_PA_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_PA_HOME
#--------------------------
