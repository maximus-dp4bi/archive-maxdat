#!/bin/bash

. ~/.bash_profile

#Complete the environment - Specific to MDHIX only
#---------------------------
#redefining these paths here to keep them separate frm CO
export STCODE=MDHIX
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/ETL/logs
export MAXDAT_MOTS_FILES=$MAXDAT_ETL_PATH/$STCODE/mots/files
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/$STCODE/ETL/scripts
PATH=$KETTLE_MDHIX_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_MDHIX_HOME
#--------------------------
