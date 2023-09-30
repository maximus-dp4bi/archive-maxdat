SELECT rownum AS DATE_PERIOD_ID
,TO_DATE('04/20/2015','mm/dd/yyyy') AS DATE_UPDATED
,TO_CHAR(d_date,'DD-MM-RRRR') AS DATE_STANDARD_1
,TO_CHAR(d_date,'MM/DD/RRRR') AS DATE_STANDARD_2
,TO_NUMBER(TO_CHAR(d_date,'RRRRMMDD')) AS DATE_STANDARD_3
,d_date AS DATE_STANDARD_4
,to_char(d_date, 'fmDay') AS DAY_OF_WEEK
,to_char(d_date, 'fmMonth') AS MONTH_NAME
,CASE WHEN to_char(d_date, 'ddd') between 80 and 171 THEN 'Spring'
      WHEN to_char(d_date, 'ddd') between 172 and 263 THEN 'Summer'
      WHEN to_char(d_date, 'ddd') between 264 and 354 THEN 'Fall'
  ELSE 'Winter' END AS SEASON
,CASE WHEN extract (month from d_date) between 1 and 3 THEN 'Calendar 1st Quarter'
      WHEN extract (month from d_date) between 4 and 6 THEN 'Calendar 2nd Quarter' 
      WHEN extract (month from d_date) between 7 and 9 THEN 'Calendar 3rd Quarter'
      ELSE 'Calendar 4th Quarter' END  AS QUARTER
, CASE WHEN extract (day from d_date + 1) = 1 THEN 'Y'  ELSE 'N' END AS LAST_DAY_IN_MONTH_IND
, CASE WHEN to_char(d_date, 'd') = '7' THEN 'Y' ELSE 'N' END AS LAST_DAY_IN_WEEK_IND
,'Unknown' AS HOLIDAY_IND
,CASE WHEN to_char(d_date, 'D') between 2 and 6 THEN 'Weekday' ELSE 'Weekend' END AS WEEKDAY_IND
,'Undetermined' AS MAJOR_EVENT
,CASE WHEN to_char(d_date, 'D') = '7' THEN d_date ELSE d_date + (7 - TO_NUMBER(to_char(d_date, 'D'))) END AS WEEK_ENDING_DATE
, lower(to_char(d_date, 'fmDDth')) AS DAY_NUMBER_IN_MONTH
,lower(to_char(d_date, 'D')) AS DAY_NUMBER_IN_WEEK
,lower(to_char(d_date, 'fmDDD')) AS DAY_NUMBER_IN_YEAR
,CASE WHEN extract (month from d_date) BETWEEN 7 and 12 THEN 'Fiscal 2nd-Half' ELSE 'Fiscal 1st-Half' END AS FISCAL_HALF_YEAR
,CASE WHEN extract (month from d_date) > 8 THEN extract (month from d_date) - 8 ELSE  extract (month from d_date) + 4 END AS FISCAL_MONTH_NUM_IN_YEAR
,CASE WHEN extract (month from d_date) between 1 and 3 THEN 'Fiscal 1st Quarter'
      WHEN extract (month from d_date) between 4 and 6 THEN 'Fiscal 2nd Quarter' 
      WHEN extract (month from d_date) between 7 and 9 THEN 'Fiscal 3rd Quarter'
      ELSE 'Fiscal 4th Quarter' END AS FISCAL_QUARTER
,CASE WHEN to_char((d_date -5), 'WW') >=  35 THEN to_char((d_date -5), 'WW') -34 ELSE to_char((d_date -5), 'WW') + 18 END AS FISCAL_WEEK
,CASE WHEN d_date >=  to_date(('01-SEP-' ||  extract (year from d_date)), 'dd-MON-RRRR') THEN extract (year from d_date) + 1 ELSE extract (year from d_date) END AS FISCAL_YEAR
,CASE WHEN to_char(d_date, 'ddd') >= 244 THEN to_char(d_date, 'ddd')-243 ELSE to_char(d_date, 'ddd') + 122 END AS FISCAL_YEAR_DAY_NUMBER
,'F'||CASE WHEN d_date >=  to_date(('01-SEP-' ||  extract (year from d_date)), 'dd-MON-RRRR') THEN extract (year from d_date) + 1 ELSE extract (year from d_date) END || '-' ||
   CASE WHEN extract (month from d_date) > 8 THEN extract (month from d_date) - 8 ELSE  extract (month from d_date) + 4 END AS FISCAL_YEAR_MONTH
,'F'||CASE WHEN d_date >=  to_date(('01-SEP-' ||  extract (year from d_date)), 'dd-MON-RRRR') THEN extract (year from d_date) + 1 ELSE extract (year from d_date) END || '-' || 
    CASE WHEN extract (month from d_date) between 1 and 3 THEN '1st Qtr'
      WHEN extract (month from d_date) between 4 and 6 THEN '2nd Qtr' 
      WHEN extract (month from d_date) between 7 and 9 THEN '3rd Qtr'
      ELSE '4th Qtr' END AS FISCAL_YEAR_QUARTER
,extract (month from d_date) AS MONTH_NUMBER_IN_YEAR
,to_char(d_date, 'WW') AS WEEK_NUMBER_IN_YEAR
,extract (year from d_date) AS YEAR_YYYY
,CASE WHEN extract (month from d_date) between 7 and 12 THEN '2nd Half' ELSE '1st Half' END AS YEAR_HALF
,extract (year from d_date)||'-'||extract (month from d_date)  AS YEAR_MONTH
,extract (year from d_date) ||'-'||CASE WHEN extract (month from d_date) between 1 and 3 THEN '1st Qtr'
      WHEN extract (month from d_date) between 4 and 6 THEN '2nd Qtr' 
      WHEN extract (month from d_date) between 7 and 9 THEN '3rd Qtr'
      ELSE '4th Qtr' END AS YEAR_QUARTER
,1 AS VERSION
,TO_DATE('04/20/2015','mm/dd/yyyy') AS DATE_OF_VALIDITY_START
,TO_DATE('12/31/2050','mm/dd/yyyy') AS DATE_OF_VALIDITY_END
,'MAXDAT' AS CREATED_BY
,TO_DATE('04/20/2015','mm/dd/yyyy') AS DATE_CREATED
,'MAXDAT' AS UPDATED_BY
,TO_CHAR(d_date,'fmMonth DD, RRRR') AS DATE_FULL
from
  (select add_months(trunc(sysdate,'YYYY'),-60) + rownum "D_DATE"
   from dual 
   connect by rownum <= (trunc(sysdate,'yyyy') - (add_months(trunc(sysdate,'yyyy'),-60)))) 
left outer join HOLIDAYS h on (D_DATE = h.HOLIDAY_DATE)
order by D_DATE asc