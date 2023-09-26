INSERT INTO MAXDAT.CC_D_INTERVAL (
  INTERVAL_START_DATE
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
  , VERSION)
SELECT 
  INTERVAL_START_DATE
  , INTERVAL_END_DATE
  , CASE WHEN datepart(hh,INTERVAL_START_DATE) < 12 THEN 'AM' ELSE 'PM' END AS "AM_PM"
  , right('0' + convert(varchar(2),datepart(hh,INTERVAL_START_DATE)),2) AS "INTERVAL_START_HOUR"
  , right('0' + convert(varchar(2),datepart(mi,INTERVAL_START_DATE)),2) AS "INTERVAL_START_MINUTE"
  , right('0' + convert(varchar(2),datepart(hh,INTERVAL_END_DATE)),2) AS "INTERVAL_END_HOUR"
  , right('0' + convert(varchar(2),datepart(mi,INTERVAL_END_DATE)),2) AS "INTERVAL_END_MINUTE"
  , INTERVAL_SECONDS
  , right('0' + convert(varchar(2),(case when datepart(hh,INTERVAL_START_DATE)<13 then datepart(hh,INTERVAL_START_DATE) else datepart(hh,INTERVAL_START_DATE)-12 end)),2)
	+ ':'   +
	right('0' + convert(varchar(2),datepart(mi,INTERVAL_START_DATE)),2) AS "INTERVAL_START_TIME_OF_DAY12"

  , right('0' + convert(varchar(2),datepart(hh,INTERVAL_START_DATE)),2)
	+ ':'   +
	right('0' + convert(varchar(2),datepart(mi,INTERVAL_START_DATE)),2) AS "INTERVAL_START_TIME_OF_DAY24"

  , right('0' + convert(varchar(2),(case when datepart(hh,INTERVAL_END_DATE)<13 then datepart(hh,INTERVAL_END_DATE) else datepart(hh,INTERVAL_END_DATE)-12 end)),2)
	+ ':'   +
	right('0' + convert(varchar(2),datepart(mi,INTERVAL_END_DATE)),2) AS "INTERVAL_END_TIME_OF_DAY12"

  , right('0' + convert(varchar(2),datepart(hh,INTERVAL_END_DATE)),2)
	+ ':'   +
	right('0' + convert(varchar(2),datepart(mi,INTERVAL_END_DATE)),2) AS "INTERVAL_END_TIME_OF_DAY24"

  , '01/01/1900' AS "RECORD_EFF_DT"
  , '12/31/2999' AS "RECORD_END_DT"
  , 1 AS "VERSION"
FROM MAXDAT.CC_S_INTERVAL
