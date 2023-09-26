#!/bin/bash
location='/u01/maximus/maxdat/CAHCO8/config'
source ${location}/.set_env
#CAHCO_run_connect_test.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# ================================================================================
# This is an AdHoc Test shell you can run to test database/mail server connections
# Run the Init Check to see if resources are available
# ================================================================================
MODULE=${MODULE_INIT}; RUN_FILE=bpm_Init_check; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_KETTLE_DIR}/kitchen.sh -file="${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb" -level="${KJB_LOG_LEVEL}"  >> ${LOG_FILE}
