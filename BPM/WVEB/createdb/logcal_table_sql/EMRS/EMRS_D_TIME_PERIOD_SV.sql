SELECT rownum AS TIME_PERIOD_ID
,TO_DATE('04/20/2015','mm/dd/yyyy') AS DATE_UPDATED
,to_char(to_date('04/20/2015 00:00:00','mm/dd/yyyy hh24:mi:ss') + rownum/86400,'hh24:mi') AS HOUR_MINUTE_MILITARY
,CASE WHEN to_date(to_char(to_date('04/20/2015 00:00:00','mm/dd/yyyy hh24:mi:ss') + rownum/86400,'mm/dd/yyyy hh24:mi:ss'),'mm/dd/yyyy hh24:mi:ss') BETWEEN to_date('04/20/2015 06:06:00','mm/dd/yyyy hh24:mi:ss') AND to_date('04/20/2015 11:59:59','mm/dd/yyyy hh24:mi:ss') THEN 'Morning'
      WHEN to_date(to_char(to_date('04/20/2015 00:00:00','mm/dd/yyyy hh24:mi:ss') + rownum/86400,'mm/dd/yyyy hh24:mi:ss'),'mm/dd/yyyy hh24:mi:ss') BETWEEN to_date('04/20/2015 12:00:00','mm/dd/yyyy hh24:mi:ss') AND to_date('04/20/2015 18:30:00','mm/dd/yyyy hh24:mi:ss') THEN 'Afternoon'
    ELSE 'Night' END AS MORNING_NOON_NIGHT
,CASE WHEN to_date(to_char(to_date('04/20/2015 00:00:00','mm/dd/yyyy hh24:mi:ss') + rownum/86400,'mm/dd/yyyy hh24:mi:ss'),'mm/dd/yyyy hh24:mi:ss') BETWEEN to_date('04/20/2015 07:00:00','mm/dd/yyyy hh24:mi:ss') AND to_date('04/20/2015 10:00:00','mm/dd/yyyy hh24:mi:ss') THEN 'Office Opening'
      WHEN to_date(to_char(to_date('04/20/2015 00:00:00','mm/dd/yyyy hh24:mi:ss') + rownum/86400,'mm/dd/yyyy hh24:mi:ss'),'mm/dd/yyyy hh24:mi:ss') BETWEEN to_date('04/20/2015 11:00:00','mm/dd/yyyy hh24:mi:ss') AND to_date('04/20/2015 13:30:00','mm/dd/yyyy hh24:mi:ss') THEN 'Lunch Hours'
      WHEN to_date(to_char(to_date('04/20/2015 00:00:00','mm/dd/yyyy hh24:mi:ss') + rownum/86400,'mm/dd/yyyy hh24:mi:ss'),'mm/dd/yyyy hh24:mi:ss') BETWEEN to_date('04/20/2015 16:00:00','mm/dd/yyyy hh24:mi:ss') AND to_date('04/20/2015 18:00:00','mm/dd/yyyy hh24:mi:ss') THEN 'Closing Hours'
    ELSE 'Other Hours' END AS OPEN_LUNCH_CLOSE
, to_char(to_date('04/20/2015 00:00:00','mm/dd/yyyy hh24:mi:ss') + rownum/86400,'fmHHpm') AS HOUR
,to_char(to_date('04/20/2015 00:00:00','mm/dd/yyyy hh24:mi:ss') + rownum/86400,'fmMI') AS MINUTE
,to_char(to_date('04/20/2015 00:00:00','mm/dd/yyyy hh24:mi:ss') + rownum/86400,'fmSS') AS SECOND
, to_char(to_date('04/20/2015 00:00:00','mm/dd/yyyy hh24:mi:ss') + rownum/86400,'HH24') AS MILITARY_HOUR      
,to_char(to_date('04/20/2015 00:00:00','mm/dd/yyyy hh24:mi:ss') + rownum/86400,'ss') AS MILITARY_SECOND
,1 VERSION
,TO_DATE('01/01/1999','mm/dd/yyyy') AS DATE_OF_VALIDITY_START
,TO_DATE('12/31/2050','mm/dd/yyyy') AS DATE_OF_VALIDITY_END
,'MAXDAT' CREATED_BY
,TO_DATE('04/09/2015','mm/dd/yyyy') AS DATE_CREATED
,'MAXDAT' AS UPDATED_BY
,to_char(to_date('04/20/2015 12:00:00','mm/dd/yyyy hh:mi:ss am') + rownum/86400,'HH:MI') AS HOUR_MINUTE
,to_char(to_date('04/20/2015 00:00:00','mm/dd/yyyy hh24:mi:ss') + rownum/86400,'mi') AS MILITARY_MINUTE
FROM dual 
CONNECT BY rownum <= 86400