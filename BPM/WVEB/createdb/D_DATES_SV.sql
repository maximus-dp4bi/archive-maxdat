CREATE OR REPLACE VIEW D_DATES
AS 
SELECT d.D_DATE,
  d.D_MONTH,
  d.D_MONTH_NAME,
  d.D_DAY,
  d.D_DAY_NAME,
  d.D_DAY_OF_WEEK,
  d.D_DAY_OF_MONTH,
  d.D_DAY_OF_YEAR,
  d.D_YEAR,
  d.D_MONTH_NUM,
  d.D_YEAR || d.D_MONTH_NUM AS D_YEAR_MONTH,
  d.D_WEEK_OF_YEAR,
  d.D_WEEK_OF_MONTH,
  d.WEEKEND_FLAG,
  d.BUSINESS_DAY_FLAG,
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
FROM MAXDAT_LOOKUP.BPM_D_DATES d
WITH READ ONLY;
  
GRANT SELECT ON MAXDAT_LOOKUP.D_DATES TO EB_MAXDAT_REPORTS;
