#!/bin/sh
source /u01/maximus/maxdat/NYEC8/config/.set_env

LOG_LEVEL="Basic"

                                                                                                   
$MAXDAT_KETTLE_DIR/kitchen.sh -file="$MAXDAT_ETL_DIR/BugFix_1/ProcessMI_Runall_BugFix.kjb" -log="$MAXDAT_LOG_DIR/ProcessMI_Runall_BugFix_1.log" -level="$LOG_LEVEL" 
