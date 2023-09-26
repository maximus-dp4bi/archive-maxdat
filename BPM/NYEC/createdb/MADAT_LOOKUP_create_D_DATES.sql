create table BPM_D_DATES tablespace NYHOPT_DATA as
select 
  D_DATE,
  to_char(D_DATE,'Mon') D_MONTH,
  to_char(D_DATE,'FMMonth') D_MONTH_NAME,
  to_char(D_DATE,'Dy') D_DAY,
  to_char(D_DATE,'Day') D_DAY_NAME,
  to_char(D_DATE,'D') D_DAY_OF_WEEK,
  to_char(D_DATE,'DD') D_DAY_OF_MONTH,
  to_char(D_DATE,'DDD') D_DAY_OF_YEAR,
  to_char(D_DATE,'YYYY') D_YEAR,
  to_char(D_DATE,'MM') D_MONTH_NUM,
  to_char(D_DATE,'IW') D_WEEK_OF_YEAR,
  to_char(D_DATE,'W') D_WEEK_OF_MONTH,
  case when to_char(D_DATE,'D') in('1','7') then 'Y' else 'N' end WEEKEND_FLAG,
  case when to_number (to_char (D_DATE,'d'))  not in ('1','7') and h.HOLIDAY_DATE is null then 'Y' else 'N' end BUSINESS_DAY_FLAG
from
  (select add_months(trunc(sysdate,'MM'),-12) + rownum "D_DATE"
   from dual 
   connect by rownum <= (add_months(trunc(sysdate,'MM'),24) - (add_months(trunc(sysdate,'MM'),-12))))
left outer join HOLIDAYS h on (D_DATE = h.HOLIDAY_DATE)
order by D_DATE asc;

alter table BPM_D_DATES add constraint BPM_D_DATES_PK primary key (D_DATE) using index tablespace NYHOPT_DATA;

grant select,references on BPM_D_DATES to ATS_MAXDAT_REPORTS;