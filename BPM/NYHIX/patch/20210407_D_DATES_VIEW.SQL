CREATE OR REPLACE FORCE EDITIONABLE VIEW MAXDAT.D_DATES 
  (D_DATE, D_WEEK, D_MONTH, D_MONTH_SHORT_NAME, D_MONTH_NAME, 
  D_DAY, D_DAY_NAME, D_DAY_OF_WEEK, D_DAY_OF_MONTH, D_DAY_OF_YEAR, D_YEAR, 
  D_MONTH_NUM, D_WEEK_NUM, D_WEEK_OF_MONTH, 
  WEEKEND_FLAG, BUSINESS_DAY_FLAG, 
  TODAY, YESTERDAY, LAST_WEEKDAY, THIS_WEEK, LAST_WEEK,
  DATE_REPORT_HEADING
  ) AS 
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
    when trunc(D_DATE) = trunc(sysdate) then 'Y'
    else 'N'
    end TODAY,
  case
    when trunc(D_DATE) = trunc(sysdate - 1) then 'Y'
    else 'N'
    end YESTERDAY,
  case
    when to_char(sysdate,'D') = '1' and trunc(D_DATE) = trunc(sysdate - 2) then 'Y'
    when to_char(sysdate,'D') = '2' and trunc(D_DATE) = trunc(sysdate - 3) then 'Y'
    when to_char(sysdate,'D') not in ('1','2') and trunc(D_DATE) = trunc(sysdate - 1) then 'Y'
    else 'N'
    end LAST_WEEKDAY,
  case
    when to_char(D_DATE,'YYYYIW') = to_char(sysdate,'YYYYIW') then 'Y'
    else 'N'
    end THIS_WEEK,
  case
    when to_char(D_DATE,'YYYYIW') = to_char(sysdate - 7,'YYYYIW') then 'Y'
    else 'N'
    end LAST_WEEK,
	replace(DATE_REPORT_HEADING,',',' '||chr(10)) as DATE_REPORT_HEADING
from BPM_D_DATES
with read only;
