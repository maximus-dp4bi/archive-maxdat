--------------------------------------------------------
--  File created - Thursday-September-12-2013   
--------------------------------------------------------
DROP VIEW "D_DATES";
--------------------------------------------------------
--  DDL for View D_DATES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_DATES" 
 ("D_DATE",
 "D_MONTH",
 "D_MONTH_NAME",
 "D_DAY",
 "D_DAY_NAME",
 "D_DAY_OF_WEEK",
 "D_DAY_OF_MONTH",
 "D_DAY_OF_YEAR",
 "D_YEAR",
 "D_MONTH_NUM",
 "D_WEEK_OF_YEAR",
 "D_WEEK_OF_MONTH",
 "WEEKEND_FLAG",
 "TODAY",
 "YESTERDAY",
 "LAST_WEEKDAY",
 "THIS_WEEK",
 "LAST_WEEK") 
 AS select 
  D_DATE,
  D_MONTH,
  D_MONTH_NAME,
  D_DAY,
  D_DAY_NAME,
  D_DAY_OF_WEEK,
  D_DAY_OF_MONTH,
  D_DAY_OF_YEAR,
  D_YEAR,
  D_MONTH_NUM,
  D_WEEK_OF_YEAR,
  D_WEEK_OF_MONTH,
  WEEKEND_FLAG,
  case
    when trunc(D_DATE) = trunc(sysdate) then 'Y'
    else 'N'
    end TODAY,
  case
    when trunc(D_DATE) = trunc(sysdate - 1) then 'Y'
    else 'N'
    end YESTERDAY,
  case
    when to_char(sysdate,
'D') = '1' and trunc(D_DATE) = trunc(sysdate - 2) then 'Y'
    when to_char(sysdate,
'D') = '2' and trunc(D_DATE) = trunc(sysdate - 3) then 'Y'
    when to_char(sysdate,
'D') not in ('1',
'2') and trunc(D_DATE) = trunc(sysdate - 1) then 'Y'
    else 'N'
    end LAST_WEEKDAY,
  case
    when to_char(D_DATE,
'YYYYIW') = to_char(sysdate,
'YYYYIW') then 'Y'
    else 'N'
    end THIS_WEEK,
  case
    when to_char(D_DATE,
'YYYYIW') = to_char(sysdate - 7,
'YYYYIW') then 'Y'
    else 'N'
    end LAST_WEEK
from BPM_D_DATES
with read only;
/
