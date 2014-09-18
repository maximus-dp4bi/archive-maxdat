#!/bin/bash
source $MD_SETENV
# Run to test for connection only
${MAXDAT_KETTLE_DIR}/kitchen.sh -file=${MAXDAT_ETL_PATH}/bpm_Init_check.kjb -level=${DETAIL_LOG_LEVEL} > ${MAXDAT_ETL_LOGS}/bpm_init_check_"$(date +%Y%m%d_%H%M%S)".log

