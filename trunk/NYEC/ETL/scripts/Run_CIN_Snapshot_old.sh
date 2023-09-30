#!/bin/sh
. ~/.bash_profile
source /u01/maximus/maxbi-uat/ETL/scripts/setenv_var
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$

$MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_PATH/scripts/LOAD_CIN_SNAPSHOT_old.ktr" -log="$MAXDAT_ETL_LOGS/LOAD_CIN_SNAPSHOT.log" -level="$KTR_LOG_LEVEL" 
