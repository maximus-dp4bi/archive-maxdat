#!/bin/bash
location='/u01/maximus/maxdat/MIEB/config'
source ${location}/.set_env
#MIEB_run_connect_test.sh
# ================================================================================
# Do not edit these four SVN_* variable values.  They are populated when you
#     commit code to SVN and used later to identify deployed code.
# $URL: svn://svn-staging.maximus.com/dev1d/maxdat/trunk/Kettle8/CAHCO/scripts/CAHCO_run_connect_test.sh $
# $Revision: 26603 $
# $Date: 2019-03-21 16:50:26 -0700 (Thu, 21 Mar 2019) $
# $Author: sr18956 $
# ================================================================================
# This is an AdHoc Test shell you can run to test database/mail server connections
# Run the Init Check to see if resources are available
# ================================================================================
MODULE=${MODULE_INIT}; RUN_FILE=bpm_Init_check; LOG_NAME=${RUN_FILE}_$(date +%Y%m%d_%H%M%S).log; LOG_FILE="${MAXDAT_ETL_LOGS}/${MODULE}/${LOG_NAME}"; ${MAXDAT_KETTLE_DIR}/kitchen.sh -file="${MAXDAT_ETL_PATH}/${MODULE}/${RUN_FILE}.kjb" -level="${KJB_LOG_LEVEL}"  >> ${LOG_FILE}
