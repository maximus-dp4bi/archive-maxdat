create table BPM_D_DATES tablespace MAXDAT_DATA as
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
  case 
    when to_char(D_DATE,'D') in('1','7') then 'Y' else 'N' 
    end WEEKEND_FLAG
from
  (select add_months(trunc(sysdate,'MM'),-12) + rownum "D_DATE"
   from dual 
   connect by rownum <= (sysdate - (add_months(trunc(sysdate,'MM'),-12))))
order by D_DATE asc;

alter table BPM_D_DATES add constraint BPM_D_DATES_PK primary key (D_DATE) using index tablespace MAXDAT_INDX;

grant select on BPM_D_DATES  to MAXDAT_READ_ONLY;

create or replace view D_DATES
  (D_DATE,D_MONTH,D_MONTH_NAME,D_DAY,D_DAY_NAME,D_DAY_OF_WEEK,D_DAY_OF_MONTH,
   D_DAY_OF_YEAR,D_YEAR,D_MONTH_NUM,D_WEEK_OF_YEAR,D_WEEK_OF_MONTH,WEEKEND_FLAG,
   TODAY,YESTERDAY,LAST_WEEKDAY,THIS_WEEK,LAST_WEEK)
as
select 
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

create or replace view BPM_D_DATE_HOUR_SV as
select bdd.D_DATE + (bdh.D_HOUR/24) D_DATE_HOUR
from 
  BPM_D_DATES bdd,
  BPM_D_HOURS bdh
where bdd.D_DATE <= sysdate - (bdh.D_HOUR/24)
with read only;

grant select on BPM_D_DATE_HOUR_SV to MAXDAT_READ_ONLY;


alter session set plsql_code_type = native;

create or replace procedure MAINTAIN_BPM_D_DATES as

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
      insert into BPM_D_DATES 
        (D_DATE,d_month,d_month_name,d_day,d_day_name,
         d_day_of_week,d_day_of_month,d_day_of_year,d_year,d_month_num,
         d_week_of_year,D_WEEK_OF_MONTH,WEEKEND_FLAG)
      values 
        (r_missing_date.missing_date,to_char(r_missing_date.missing_date,'Mon'),to_char(r_missing_date.missing_date,'FMMonth'),to_char(r_missing_date.missing_date,'Dy'), to_char(r_missing_date.missing_date,'Day'),
         to_char(r_missing_date.missing_date,'D'),to_char(r_missing_date.missing_date,'DD'),to_char(r_missing_date.missing_date,'DDD'),to_char(r_missing_date.missing_date,'YYYY'),to_char(r_missing_date.missing_date,'MM'),
         to_char(r_missing_date.missing_date,'IW'),TO_CHAR(r_missing_date.missing_date,'W'),case when TO_CHAR(r_missing_date.missing_date,'D') in('1','7') then 'Y' else 'N' end);
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

