# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
#   SVN_FILE_URL := '$URL$'; 
#   SVN_REVISION := '$Revision$'; 
#   SVN_REVISION_DATE := '$Date$'; 
#   SVN_REVISION_AUTHOR := '$Author$';
# ================================================================================

. /u01/maximus/maxdat-uat/CiscoEnterprise8/ETL/scripts/ContactCenter/main/bin/.set_env


#Complete the environment - Specific to CiscoEnterprise only
#----------------------------------------------------------------------------------------------------------------------------------------
export STCODE=CiscoEnterprise8
export MAXDAT_ETL_LOGS=$MAXDAT_ETL_PATH/$STCODE/ETL/logs
export MAXDAT_MOTS_FILES=$MAXDAT_ETL_PATH/$STCODE/mots/files
export MAXDAT_ETL_PATH=$MAXDAT_ETL_PATH/$STCODE/ETL/scripts
PATH=$KETTLE_CiscoEnterprise_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export PATH
export KETTLE_HOME=$KETTLE_CiscoEnterprise_HOME

#---- OTHER VARIABLES ----
export LOG_LIFE_DAYS=60 # Number of days to keep log files in the log directory before deleting
#----------------------------------------------------------------------------------------------------------------------------------------
