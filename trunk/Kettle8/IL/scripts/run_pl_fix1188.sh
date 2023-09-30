#!/bin/sh
. /u01/maximus/maxdat-prd/IL8/scripts/.set_env

LOG_LEVEL="Basic"

$SCRIPTS_DIR/kitchen.sh -file="$CUSTOM_DIR/ProcessLetter_Fix1188.kjb" -log="$LOG_DIR/ProcessLetter_Fix1188.log" -level="$LOG_LEVEL" 