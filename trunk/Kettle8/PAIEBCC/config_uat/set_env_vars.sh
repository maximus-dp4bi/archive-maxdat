#!/bin/bash
. ~/.bash_profile

# set_env_vars.sh
# =======================================================================================================================================
# Do not edit these four SVN_* variable values.  They are populated when
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/ContactCenter/trunk/kettle/MAXDAT/implementation/PA/bin/set_env_vars.sh $
# $Revision: 23101 $
# $Date: 2018-04-20 12:04:05 -0600 (Fri, 20 Apr 2018) $
# $Author: TM151500 $
# =======================================================================================================================================


#Complete the environment - Specific to PA only
#----------------------------------------------------------------------------------------------------------------------------------------
export STCODE=PA
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/logs
export MAXDAT_MOTS_FILES=$MAXDAT_ETL_PATH/$STCODE/mots/files
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/$STCODE/scripts
PATH=$KETTLE_PA_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_PA_HOME

#---- OTHER VARIABLES ----
export LOG_LIFE_DAYS=60 # Number of days to keep log files in the log directory before deleting
#----------------------------------------------------------------------------------------------------------------------------------------
