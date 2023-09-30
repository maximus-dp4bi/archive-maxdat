
#Dave Dillon's script:
#find $MAXDAT_ETL_LOGS \( -ctime +$LOG_LIFE_DAYS -o -size 0 \) -exec rm -f '{}' \;


find $MAXDAT_ETL_LOGS \( -ctime +$LOG_LIFE_DAYS -o -size -$MIN_LOG_SIZE \) -exec rm -f '{}' \;