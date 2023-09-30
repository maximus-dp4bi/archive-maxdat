
--drop table  maxdat_support.BPM_D_DATES

create table maxdat_support.BPM_D_DATES
as
 select 
  D_DATE,
  to_char(D_DATE,'Mon') D_MONTH_SHORT_NAME,
  to_char(D_DATE,'FMMonth') D_MONTH_NAME,
  to_char(D_DATE,'Dy') D_DAY,
  to_char(D_DATE,'Day') D_DAY_NAME,
  to_char(D_DATE,'D') D_DAY_OF_WEEK,
  to_char(D_DATE,'DD') D_DAY_OF_MONTH,
  to_char(D_DATE,'DDD') D_DAY_OF_YEAR,
  to_char(D_DATE,'YYYY') D_YEAR,
  to_char(D_DATE,'MM') D_MONTH_NUM,
  to_char(D_DATE,'IW') D_WEEK_NUM,
  to_char(D_DATE,'W') D_WEEK_OF_MONTH,
   case when to_char(D_DATE,'D') in('1','7') then 'Y' else 'N' end WEEKEND_FLAG,
  case when to_char (D_DATE,'d')  not in ('1','7') then 'Y' else 'N' end BUSINESS_DAY_FLAG,
  (CASE WHEN TO_CHAR(d_date,'iw') = '01' THEN TO_CHAR(DATE_TRUNC('week',d_date)+interval '6' day,'YYYY')
      ELSE TO_CHAR(DATE_TRUNC('week',d_date),'YYYY')END ||TO_CHAR(d_date,'iw'))::numeric d_week,
  (to_char(D_DATE,'YYYY')||to_char(D_DATE,'MM'))::numeric  d_month
from (
SELECT D_DATE 
FROM generate_series(CAST('2019-12-01' as TIMESTAMP), CAST('2025-12-31' as TIMESTAMP), interval '1' day) as D_DATE
) t
;

ALTER TABLE maxdat_support.BPM_D_DATES OWNER TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.BPM_D_DATES TO maxdat_support;
GRANT SELECT ON TABLE maxdat_support.BPM_D_DATES TO maxdat_reports;

create or replace view maxdat_support.D_DATES 
as
select 
  D_DATE,
  D_WEEK,
  D_MONTH,
  D_MONTH_SHORT_NAME,
  D_MONTH_NAME,
  D_DAY,
  D_DAY_NAME,
  D_DAY_OF_WEEK,
  D_DAY_OF_MONTH,
  D_DAY_OF_YEAR,
  D_YEAR,
  D_MONTH_NUM,
  D_WEEK_NUM,
  D_WEEK_OF_MONTH,
  WEEKEND_FLAG,
  BUSINESS_DAY_FLAG,
  case
    when cast(D_DATE as date) = cast(now() as date) then 'Y'
    else 'N'
    end TODAY,
  case
    when cast(D_DATE as date) = cast(now() -interval '1' day as date) then 'Y'
    else 'N'
    end YESTERDAY,
  case
    when to_char(now(),'D') = '1' and cast(D_DATE as date) = cast(now() -interval '2' day as date) then 'Y'
    when to_char(now(),'D') = '2' and cast(D_DATE as date) = cast(now() -interval '3' day as date) then 'Y'
    when to_char(now(),'D') not in ('1','2') and cast(D_DATE as date) = cast(now() -interval '1' day as date) then 'Y'
    else 'N'
    end LAST_WEEKDAY,
  case
    when to_char(D_DATE,'YYYYIW') = to_char(now(),'YYYYIW') then 'Y'
    else 'N'
    end THIS_WEEK,
  case
    when to_char(D_DATE,'YYYYIW') = to_char(now()-interval '7' day,'YYYYIW') then 'Y'
    else 'N'
    end LAST_WEEK
from maxdat_support.BPM_D_DATES
;
ALTER TABLE maxdat_support.D_DATES OWNER TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.D_DATES TO maxdat_support;
GRANT SELECT ON TABLE maxdat_support.D_DATES TO maxdat_reports;