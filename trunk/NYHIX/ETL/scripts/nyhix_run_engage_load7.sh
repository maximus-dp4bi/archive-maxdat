#!/bin/ksh
#. ~/.bash_profile

# nyhix_run_engage_load.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# =================================================================================


$MAXDAT_ETL_PATH/run_kjb7.sh  $MAXDAT_ETL_PATH/Engage/Engage_Process_Files.kjb $KJB_LOG_LEVEL >> $MAXDAT_ETL_LOGS/Engage_Process_Files7_$(date +%Y%m%d_%H%M%S).LOG

