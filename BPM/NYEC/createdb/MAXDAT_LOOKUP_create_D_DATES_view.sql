CREATE OR REPLACE FORCE VIEW 
"D_DATES" ("D_DATE", "D_MONTH", "D_MONTH_NAME", "D_DAY", "D_DAY_NAME", "D_DAY_OF_WEEK", "D_DAY_OF_MONTH", "D_DAY_OF_YEAR", "D_YEAR", "D_MONTH_NUM", "D_WEEK_OF_YEAR", "D_WEEK_OF_MONTH", "WEEKEND_FLAG", "BUSINESS_DAY_FLAG", "TODAY", "YESTERDAY", "LAST_WEEKDAY", "THIS_WEEK", "LAST_WEEK") AS 
  select
  d.D_DATE,
  d.D_MONTH,
  d.D_MONTH_NAME,
  d.D_DAY,
  d.D_DAY_NAME,
  d.D_DAY_OF_WEEK,
  d.D_DAY_OF_MONTH,
  d.D_DAY_OF_YEAR,
  d.D_YEAR,
  d.D_MONTH_NUM,
  d.D_WEEK_OF_YEAR,
  d.D_WEEK_OF_MONTH,
  d.WEEKEND_FLAG,
  case when to_number (to_char (d.D_DATE,'d'))  not in ('1','7') and h.HOLIDAY_DATE is null then 'Y' else 'N' end BUSINESS_DAY_FLAG,
  case
    when trunc(d.D_DATE) = trunc(sysdate) then 'Y'
    else 'N'
    end TODAY,
  case
    when trunc(d.D_DATE) = trunc(sysdate - 1) then 'Y'
    else 'N'
    end YESTERDAY,
  case
    when to_char(sysdate,'D') = '1' and trunc(d.D_DATE) = trunc(sysdate - 2) then 'Y'
    when to_char(sysdate,'D') = '2' and trunc(d.D_DATE) = trunc(sysdate - 3) then 'Y'
    when to_char(sysdate,'D') not in ('1','2') and trunc(d.D_DATE) = trunc(sysdate - 1) then 'Y'
    else 'N'
    end LAST_WEEKDAY,
  case
    when to_char(d.D_DATE,'YYYYIW') = to_char(sysdate,'YYYYIW') then 'Y'
    else 'N'
    end THIS_WEEK,
  case
    when to_char(d.D_DATE,'YYYYIW') = to_char(sysdate - 7,'YYYYIW') then 'Y'
    else 'N'
    end LAST_WEEK
from BPM_D_DATES d
left outer join NYHOPT.HOLIDAYS h on (d.D_DATE = h.HOLIDAY_DATE)
where d.d_date<=sysdate 
with read only;

grant select, references on d_dates to ATS_MAXDAT_REPORTS;

