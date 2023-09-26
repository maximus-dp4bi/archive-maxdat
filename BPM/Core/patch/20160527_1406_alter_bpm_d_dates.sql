ALTER TABLE bpm_d_dates
RENAME COLUMN d_week_of_year to d_week_num;

ALTER TABLE bpm_d_dates
RENAME COLUMN d_month to d_month_short_name;

ALTER TABLE bpm_d_dates
ADD (d_week NUMBER
    ,d_month NUMBER);
    

UPDATE bpm_d_dates
SET d_month = TO_NUMBER(D_YEAR||D_MONTH_NUM),
    d_week = TO_NUMBER(CASE WHEN d_week_num = 1 THEN TO_CHAR(TRUNC(d_date,'iw')+6,'YYYY')
      ELSE TO_CHAR(TRUNC(d_date,'iw'),'YYYY') END ||d_week_num)
      ;

commit;

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

grant select on D_DATES to MAXDAT_READ_ONLY;


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
    where rownum <= trunc(sysdate) - max_bpm_d_date.max_date;

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