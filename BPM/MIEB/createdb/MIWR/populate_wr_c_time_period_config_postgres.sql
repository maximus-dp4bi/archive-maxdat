create table maxdat_support.cc_s_interval(interval_start_date,interval_end_date,interval_seconds)
as
select x.starttime,lead(x.starttime,1) over(order by x.starttime) - INTERVAL '1' second endtime, 1799
from(
SELECT starttime::timestamp
FROM   generate_series(timestamp '2019-01-01 00:00'
                     , timestamp '2025-12-31 23:59'
                     , interval  '30 min') t(starttime)
) x ;


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
  ,CASE WHEN extract(hour from INTERVAL_START_DATE) < 12 THEN 'AM' ELSE 'PM' END AS "AM_PM"
  ,extract(hour from INTERVAL_START_DATE) AS "INTERVAL_START_HOUR"
  ,extract(minute from INTERVAL_START_DATE) AS "INTERVAL_START_MINUTE"
  ,extract(hour from INTERVAL_END_DATE) AS "INTERVAL_END_HOUR"
  ,extract(minute from INTERVAL_END_DATE) AS "INTERVAL_END_MINUTE"
  , INTERVAL_SECONDS
  ,to_char(INTERVAL_START_DATE, 'HH:MI') AS "INTERVAL_START_TIME_OF_DAY12"
  ,to_char(INTERVAL_START_DATE, 'HH24:MI') AS "INTERVAL_START_TIME_OF_DAY24"
  ,to_char(INTERVAL_END_DATE, 'HH:MI') AS "INTERVAL_END_TIME_OF_DAY12"
  ,to_char(INTERVAL_END_DATE, 'HH24:MI') AS "INTERVAL_END_TIME_OF_DAY24"
  , '01/01/1900' AS "RECORD_EFF_DT"
  , '12/31/2999' AS "RECORD_END_DT"
  , 1 AS "VERSION"
  ,now()
  ,now()
  ,'maxdat_support'
  ,'maxdat_support'
FROM maxdat_support.CC_S_INTERVAL
  ;
 
commit;

drop table maxdat_support.cc_s_interval;  