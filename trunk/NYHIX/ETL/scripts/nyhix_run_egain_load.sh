#!/bin/ksh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
#   SVN_FILE_URL varchar2(200) := '$URL$'; 
#   SVN_REVISION varchar2(20) := '$Revision$'; 
#   SVN_REVISION_DATE varchar2(60) := '$Date$'; 
#   SVN_REVISION_AUTHOR varchar2(20) := '$Author$';
# ================================================================================

. ~/.bash_profile
$MAXDAT_ETL_PATH/.setenv_var.sh

#export PATH=$KETTLE_NYHIX_HOME/.kettle/kettle.properties:.:/u01/app/appadmin/product/pentaho/data-integration/:$PATH
export KETTLE_HOME=$KETTLE_NYHIX_HOME
export DETAIL_LOG_LEVEL="Detailed"

$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_PATH/Egain/Egain_Processing_Files.kjb" -log="$MAXDAT_ETL_LOGS/Egain_Process_Files_$(date +%Y%m%d_%H%M%S).log" -level="$DETAIL_LOG_LEVEL"
