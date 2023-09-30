
create table HOLIDAYS
  (HOLIDAY_ID   number(18) not null,
   HOLIDAY_YEAR number(4),
   HOLIDAY_DATE date,
   DESCRIPTION  varchar2(128),
   CREATED_BY   varchar2(80),
   CREATE_TS    date,
   UPDATED_BY   varchar2(80),
   UPDATE_TS    date)
tablespace MAXDAT_TBS;

alter table HOLIDAYS add constraint HOLIDAYS_PK primary key (HOLIDAY_ID)
using index tablespace MAXDAT_TBS;

alter table HOLIDAYS add constraint HOLIDAYS_UK1 unique (HOLIDAY_DATE) 
using index tablespace MAXDAT_TBS;

alter index HOLIDAYS_UK1 invisible;

grant select on HOLIDAYS to MAXDAT_REPORTS; 

create table BPM_D_DATES tablespace MAXDAT_TBS as
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
  case when to_number (to_char (D_DATE,'d'))  not in ('1','7') and h.HOLIDAY_DATE is null then 'Y' else 'N' end BUSINESS_DAY_FLAG,
  CASE WHEN TO_CHAR(d_date,'iw') = 1 THEN TO_CHAR(TRUNC(d_date,'iw')+6,'YYYY')
      ELSE TO_CHAR(TRUNC(d_date,'iw'),'YYYY')END ||TO_CHAR(d_date,'iw') d_week,  
  to_number(to_char(D_DATE,'YYYY')||to_char(D_DATE,'MM')) d_month
from
  (select add_months(trunc(sysdate,'MM'),-12) + rownum "D_DATE"
   from dual 
   connect by rownum <= (sysdate - (add_months(trunc(sysdate,'MM'),-12))))
left outer join HOLIDAYS h on (D_DATE = h.HOLIDAY_DATE)
order by D_DATE asc;

alter table BPM_D_DATES add constraint BPM_D_DATES_PK primary key (D_DATE) using index tablespace MAXDAT_TBS;

grant select on BPM_D_DATES to MAXDAT_REPORTS;

create or replace view D_DATES
  (D_DATE,D_WEEK,D_MONTH,D_MONTH_SHORT_NAME,D_MONTH_NAME,D_DAY,D_DAY_NAME,D_DAY_OF_WEEK,D_DAY_OF_MONTH,
   D_DAY_OF_YEAR,D_YEAR,D_MONTH_NUM,D_WEEK_NUM,D_WEEK_OF_MONTH,WEEKEND_FLAG,
   BUSINESS_DAY_FLAG,TODAY,YESTERDAY,LAST_WEEKDAY,THIS_WEEK,LAST_WEEK)
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
    end LAST_WEEK
from BPM_D_DATES
with read only;

grant select on D_DATES to MAXDAT_REPORTS;

    
alter session set plsql_code_type = native;

create or replace procedure MAINTAIN_BPM_D_DATES as

  v_is_holiday integer := null;

  cursor c_missing_dates is
    with max_bpm_d_date as
      (select max(D_DATE) max_date
       from BPM_D_DATES)
    select trunc(max_bpm_d_date.max_date + rownum) missing_date
    from 
      ALL_OBJECTS, 
      max_bpm_d_date
    where rownum <= trunc(add_months(sysdate,1),'MM')-1 - max_bpm_d_date.max_date;

  begin
  
    for r_missing_date in c_missing_dates
    loop
    
      select count(*) 
      into v_is_holiday
      from HOLIDAYS
      where HOLIDAY_DATE = r_missing_date.missing_date;
      
      insert into BPM_D_DATES 
        (D_DATE,d_month_short_name,d_month_name,d_day,d_day_name,
         d_day_of_week,d_day_of_month,d_day_of_year,d_year,d_month_num,
         d_week_num,D_WEEK_OF_MONTH,WEEKEND_FLAG,BUSINESS_DAY_FLAG,d_week,d_month)
      values 
        (r_missing_date.missing_date,to_char(r_missing_date.missing_date,'Mon'),to_char(r_missing_date.missing_date,'FMMonth'),to_char(r_missing_date.missing_date,'Dy'), to_char(r_missing_date.missing_date,'Day'),
         to_char(r_missing_date.missing_date,'D'),to_char(r_missing_date.missing_date,'DD'),to_char(r_missing_date.missing_date,'DDD'),to_char(r_missing_date.missing_date,'YYYY'),to_char(r_missing_date.missing_date,'MM'),
         to_char(r_missing_date.missing_date,'IW'),TO_CHAR(r_missing_date.missing_date,'W'),
         case when to_char(r_missing_date.missing_date,'D') in ('1','7') then 'Y' else 'N' end,
         case when to_char(r_missing_date.missing_date,'D') not in ('1','7') and v_is_holiday = 0 then 'Y' else 'N' end,
         to_number(CASE WHEN to_char(r_missing_date.missing_date,'IW') = 1 THEN TO_CHAR(TRUNC(r_missing_date.missing_date,'iw')+6,'YYYY')
           ELSE TO_CHAR(TRUNC(r_missing_date.missing_date,'iw'),'YYYY') END ||TO_CHAR(r_missing_date.missing_date,'IW')),
         to_number(to_char(r_missing_date.missing_date,'YYYY')||to_char(r_missing_date.missing_date,'MM'))    );
    end loop;
    commit;
    
  end;
/

commit;

alter session set plsql_code_type = interpreted;

declare
  v_jobnum number := null;
begin
  dbms_job.submit(
    job => v_jobnum,
    what => 'MAINTAIN_BPM_D_DATES;',
    next_date => sysdate,
    interval => 'trunc(sysdate + 1)');
  commit;
end;
/

commit;

CREATE MATERIALIZED VIEW d_weeks
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_week,d_week_num, CASE WHEN d_week_num = 1 THEN MAX(d_year) ELSE MIN(d_year) END d_year      
     ,MIN(d_date) d_week_start, MAX(d_date) d_week_end
from bpm_d_dates
group by d_week,d_week_num;

grant select on d_weeks to MAXDAT_REPORTS;

CREATE MATERIALIZED VIEW d_months
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_month, d_month_num, d_year,d_month_short_name, d_month_name, d_month_name||' '||d_year month_name_year,MIN(d_date) d_month_start, MAX(d_date) d_month_end
FROM bpm_d_dates
GROUP BY d_month, d_month_num, d_year,d_month_short_name, d_month_name;

grant select on d_months to MAXDAT_REPORTS;

CREATE MATERIALIZED VIEW d_years
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_year, MIN(d_date) d_year_start, MAX(d_date) d_year_end
FROM bpm_d_dates
GROUP BY d_year;

grant select on d_years to MAXDAT_REPORTS;

CREATE OR REPLACE PROCEDURE refresh_d_dates_views
AS
BEGIN
  dbms_mview.refresh('D_YEARS','?');
  dbms_mview.refresh('D_MONTHS','?');
  dbms_mview.refresh('D_WEEKS','?');
END;
/

declare
  v_jobnum number := null;
begin
  dbms_job.submit(
    job => v_jobnum,
    what => 'REFRESH_D_DATES_VIEWS;',
    next_date => sysdate,
    interval => 'trunc(sysdate + 1)');
  commit;
end;
/
