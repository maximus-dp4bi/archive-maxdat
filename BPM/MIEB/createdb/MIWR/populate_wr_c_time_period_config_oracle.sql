create table maxdat_support.cc_s_interval(interval_start_date,interval_end_date,interval_seconds)
as
select start_date,lead(start_date,1)  over (order by start_date) -1/86400 end_date,1799 interval_seconds
from (
SELECT DATE '2019-12-01' + ( LEVEL - 1 ) * INTERVAL '30' MINUTE AS start_date
FROM   DUAL
CONNECT BY DATE '2019-12-01' + ( LEVEL - 1 ) * INTERVAL '30' MINUTE <= DATE '2025-12-31'
);

--truncate table maxdat_support.wr_c_time_period_config;
INSERT INTO maxdat_support.wr_c_time_period_config (
  d_interval_id
  ,INTERVAL_START_DATE
  , INTERVAL_END_DATE
  , AM_PM
  , INTERVAL_START_HOUR
  , INTERVAL_START_MINUTE
  , INTERVAL_END_HOUR
  , INTERVAL_END_MINUTE
  , INTERVAL_SECONDS
  , INTERVAL_START_TIME_OF_DAY12
  , INTERVAL_START_TIME_OF_DAY24
  , INTERVAL_END_TIME_OF_DAY12
  , INTERVAL_END_TIME_OF_DAY24
  , RECORD_EFF_DT
  , RECORD_END_DT
  , version
  ,create_date
  ,update_date
  ,created_by
  ,updated_by)
SELECT 
  row_number() over (order by interval_start_date) rn
  ,INTERVAL_START_DATE
  ,INTERVAL_END_DATE
  ,CASE WHEN to_number(to_char(INTERVAL_START_DATE,'hh24')) < 12 THEN 'AM' ELSE 'PM' END AS "AM_PM"
  ,to_number(to_char(INTERVAL_START_DATE,'hh24')) AS "INTERVAL_START_HOUR"
  ,to_number(to_char(INTERVAL_START_DATE,'mi')) AS "INTERVAL_START_MINUTE"
  ,to_number(to_char(INTERVAL_END_DATE,'hh24')) AS "INTERVAL_END_HOUR"
  ,to_number(to_char(INTERVAL_END_DATE,'mi')) AS "INTERVAL_END_MINUTE"
  , INTERVAL_SECONDS
  ,to_char(INTERVAL_START_DATE, 'HH:MI') "INTERVAL_START_TIME_OF_DAY12"
  ,to_char(INTERVAL_START_DATE, 'HH24:MI') AS "INTERVAL_START_TIME_OF_DAY24"
  ,to_char(INTERVAL_END_DATE, 'HH:MI') AS "INTERVAL_END_TIME_OF_DAY12"  
  ,to_char(INTERVAL_END_DATE, 'HH24:MI') AS "INTERVAL_END_TIME_OF_DAY24"
  , to_date('01/01/1900','mm/dd/yyyy') AS "RECORD_EFF_DT"
  ,to_date('12/31/2999','mm/dd/yyyy') AS "RECORD_END_DT"
  , 1 AS "VERSION"
  ,sysdate
  ,sysdate
  ,user
  ,user
FROM maxdat_support.CC_S_INTERVAL
  ;

commit;  
drop table maxdat_support.cc_s_interval;  
