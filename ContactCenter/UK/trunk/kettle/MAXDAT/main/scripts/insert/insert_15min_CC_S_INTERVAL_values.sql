-- insert_stg_interval.sql
--
-- populates the STG_INTERVAL table with 15, 30, and 60 minute intervals


WITH mycte AS
(
  SELECT CAST('2013-01-01' AS DATETIME) DateValue
  UNION ALL
  SELECT  dateadd(mi,15,DateValue)
  FROM    mycte   
  WHERE   dateadd(mi,15,DateValue) < '2020-01-01'
)


insert into MAXDAT.CC_S_INTERVAL(INTERVAL_START_DATE, INTERVAL_END_DATE,INTERVAL_SECONDS)

SELECT  DateValue,dateadd(mi,15,DateValue),900
FROM    mycte
OPTION (MAXRECURSION 0)

