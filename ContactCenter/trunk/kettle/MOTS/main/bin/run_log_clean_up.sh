#!/bin/bash

BASEDIR=$(dirname $0)
. $BASEDIR/set_env_vars.sh

#Dave Dillon's script:
#find $MAXDAT_ETL_LOGS \( -ctime +$LOG_LIFE_DAYS -o -size 0 \) -exec rm -f '{}' \;

find $MOTS_ETL_LOGS \( -ctime +$LOG_LIFE_DAYS -o -size -$MIN_LOG_SIZE \) -exec rm -f '{}' \;