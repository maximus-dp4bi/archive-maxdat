#!/bin/bash
. ~/.bash_profile

# set_env_vars.sh
# =======================================================================================================================================
# Do not edit these four SVN_* variable values.  They are populated when
#    you commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# =======================================================================================================================================


#Complete the environment - Specific to Product only
#----------------------------------------------------------------------------------------------------------------------------------------
export STCODE=Product
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/ETL/logs
export MAXDAT_MOTS_FILES=$MAXDAT_ETL_PATH/$STCODE/mots/files
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/$STCODE/ETL/scripts
PATH=$KETTLE_PRODUCT_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_PRODUCT_HOME

#---- OTHER VARIABLES ----
export LOG_LIFE_DAYS=60 # Number of days to keep log files in the log directory before deleting
#----------------------------------------------------------------------------------------------------------------------------------------
