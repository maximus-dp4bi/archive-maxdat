#! /bin/bash
location='/u01/maximus/maxdat/AMP_ETL/Config'
source ${location}/.set_env

find $Clear2Work_COMPLETED_FILES \( -ctime +$SOURCE_LIFE_DAYS -o -size 0 \) -exec rm -f '{}' \;
