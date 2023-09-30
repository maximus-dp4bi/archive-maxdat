#!/bin/bash
#. ~/.bash_profile
. /u01/maximus/maxdat-dev/CiscoEnterprise8/ETL/scripts/ContactCenter/main/bin/.set_env

# set_env_vars.sh
# =======================================================================================================================================
# Do not edit these four SVN_* variable values.  They are populated when
#    you commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/ContactCenter/trunk/kettle/MAXDAT/implementation/CiscoEnterprise/bin/set_env_vars.sh $
# $Revision: 23077 $
# $Date: 2018-04-20 11:22:23 -0400 (Fri, 20 Apr 2018) $
# $Author: TM151500 $
# =======================================================================================================================================


#Complete the environment - Specific to CiscoEnterprise only
#----------------------------------------------------------------------------------------------------------------------------------------
export STCODE=CiscoEnterprise
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/ETL/logs
export MAXDAT_MOTS_FILES=$MAXDAT_ETL_PATH/$STCODE/mots/files
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/$STCODE/ETL/scripts
PATH=$KETTLE_CiscoEnterprise_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_CiscoEnterprise_HOME

#---- OTHER VARIABLES ----
export LOG_LIFE_DAYS=60 # Number of days to keep log files in the log directory before deleting
#----------------------------------------------------------------------------------------------------------------------------------------
