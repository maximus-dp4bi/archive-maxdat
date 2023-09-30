#! /bin/bash
location='/u01/maximus/maxdat/MIEB/config'
source ${location}/.set_env

find $MAXDAT_ETL_LOGS -mtime +30 -type f -exec rm -f '{}' \;
