#!/bin/sh
. ./.set_env
# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#    and used later to identify deployed code. 
# $URL$
# $Revision$
# $Date$
# $Author$

$MAXDAT_KETTLE_DIR/pan.sh -file="$MAXDAT_ETL_PATH/LOAD_CIN_SNAPSHOT.ktr" -log="$MAXDAT_ETL_LOGS/LOAD_CIN_SNAPSHOT.log" -level="$KTR_LOG_LEVEL" 
